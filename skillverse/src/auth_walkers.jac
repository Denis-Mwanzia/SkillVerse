import nodes;
import std;

# =========================================
# AUTHENTICATION WALKERS
# =========================================

# Helper function to hash password
def hash_password(password: str) -> str {
    import hashlib;
    return hashlib.sha256(password.encode()).hexdigest();
}

# Helper function to generate token
def generate_token(username: str) -> str {
    import time;
    import uuid;
    timestamp = time.time();
    random_str = str(uuid.uuid4())[:8];
    token = username + "_" + str(timestamp) + "_" + random_str;
    return token;
}

# Helper function to validate email format
def validate_email(email: str) -> bool {
    if not email or email == "" {
        return false;
    }
    has_at = false;
    has_dot = false;
    for char in email {
        if char == "@" {
            has_at = true;
        }
        if char == "." and has_at {
            has_dot = true;
        }
    }
    return has_at and has_dot;
}

# Walker for user signup (public - no auth required)
walker user_create {
    obj __specs__ {
        static has methods: list = ["post"];
        static has auth: bool = False;  # Public endpoint
    }
    
    has username: str;
    has password: str;
    has email: str = "";
    has name: str = "";
    
    can entry with `root entry {
        # Validate username
        if not self.username or self.username == "" {
            report {"error": "Username is required", "success": false};
            return;
        }
        
        # Validate email format
        if self.email and self.email != "" {
            if not validate_email(self.email) {
                report {"error": "Invalid email format", "success": false};
                return;
            }
        }
        
        # Validate password
        if not self.password or self.password == "" {
            report {"error": "Password is required", "success": false};
            return;
        }
        if len(self.password) < 6 {
            report {"error": "Password must be at least 6 characters", "success": false};
            return;
        }
        
        # Check if user already exists
        users = --> User;
        for user in users {
            if user.username == self.username {
                report {"error": "Username already exists", "success": false};
                return;
            }
            if self.email and self.email != "" and user.email == self.email {
                report {"error": "Email already registered", "success": false};
                return;
            }
        }
        
        # Create user
        password_hash = hash_password(self.password);
        token = generate_token(self.username);
        
        import time;
        current_time = time.time();
        user_node = spawn here --> node::User(
            username=self.username,
            email=self.email or "",
            password_hash=password_hash,
            name=self.name or "",
            token=token,
            token_created_at=current_time,
            created_at=current_time,
            last_active=current_time
        );
        
        report {
            "success": true,
            "token": token,
            "user_id": user_node.jid,
            "username": self.username,
            "message": "User created successfully"
        };
    }
    }

# Walker for user login (public - no auth required)
walker user_login {
    obj __specs__ {
        static has methods: list = ["post"];
        static has auth: bool = False;  # Public endpoint
    }
    
    has username: str;
    has password: str;
    
    can entry with `root entry {
        if not self.username or self.username == "" {
            report {"error": "Username is required", "success": false};
            return;
        }
        if not self.password or self.password == "" {
            report {"error": "Password is required", "success": false};
            return;
        }
        
        # Find user
        users = --> User;
        user_node = null;
        for user in users {
            if user.username == self.username {
                user_node = user;
                break;
            }
        }
        
        if not user_node {
            report {"error": "Invalid username or password", "success": false};
            return;
        }
        
        # Validate password
        password_hash = hash_password(self.password);
        if user_node.password_hash != password_hash {
            report {"error": "Invalid username or password", "success": false};
            return;
        }
        
        # Generate new token and update user
        import time;
        token = generate_token(self.username);
        user_node.token = token;
        user_node.token_created_at = time.time();
        user_node.last_active = time.time();
        
        report {
            "success": true,
            "token": token,
            "user_id": user_node.jid,
            "username": user_node.username,
            "email": user_node.email,
            "name": user_node.name,
            "message": "Login successful"
        };
    }
    }

# Walker to verify token (public - used for auth checks)
walker verify_token {
    obj __specs__ {
        static has methods: list = ["post"];
        static has auth: bool = False;  # Public - used to check auth
    }
    
    has token: str;
    
    can entry with `root entry {
        if not self.token or self.token == "" {
            report {"valid": false, "error": "Token required"};
            return;
        }
        
        # Find user by token
        users = --> User;
        user_node = null;
        for user in users {
            if user.token == self.token {
                user_node = user;
                break;
            }
        }
        
        if not user_node {
            report {"valid": false, "error": "Invalid token"};
            return;
        }
        
        # Check token expiration (24 hours = 86400 seconds)
        import time;
        current_time = time.time();
        token_created = user_node.token_created_at;
        if token_created == 0.0 {
            user_node.token = "";
            report {"valid": false, "error": "Invalid token"};
            return;
        }
        token_age = current_time - token_created;
        if token_age > 86400 {
            user_node.token = "";
            report {"valid": false, "error": "Token expired"};
            return;
        }
        
        report {
            "valid": true,
            "user_id": user_node.jid,
            "username": user_node.username,
            "email": user_node.email,
            "name": user_node.name
        };
    }
    }

# Walker to get current user (requires authentication)
walker get_current_user {
    obj __specs__ {
        static has methods: list = ["get", "post"];
        static has auth: bool = True;  # Requires authentication
    }
    
    has token: str = "";  # Optional - also comes from Authorization header
    
    can entry with `root entry {
        # Token should come from Authorization header when auth=True
        # But we can also accept it as parameter for testing
        if not self.token or self.token == "" {
            report {"error": "Token required", "success": false};
            return;
        }
        
        # Verify token
        users = --> User;
        user_node = null;
        for user in users {
            if user.token == self.token {
                user_node = user;
                break;
            }
        }
        
        if not user_node {
            report {"error": "Invalid token", "success": false};
            return;
        }
        
        # Check token expiration
        import time;
        current_time = time.time();
        token_created = user_node.token_created_at;
        if token_created == 0.0 {
            user_node.token = "";
            report {"error": "Invalid token", "success": false};
            return;
        }
        token_age = current_time - token_created;
        if token_age > 86400 {
            user_node.token = "";
            report {"error": "Token expired", "success": false};
            return;
        }
        
        # Update last active
        import time;
        user_node.last_active = time.time();
        
        report {
            "success": true,
            "user": {
                "user_id": user_node.jid,
                "username": user_node.username,
                "email": user_node.email,
                "name": user_node.name,
                "experience_level": user_node.experience_level,
                "goals": user_node.goals,
                "created_at": user_node.created_at,
                "last_active": user_node.last_active
            }
        };
    }
    }

# Walker to logout (requires authentication)
walker user_logout {
    obj __specs__ {
        static has methods: list = ["post"];
        static has auth: bool = True;  # Requires authentication
    }
    
    has token: str = "";
    
    can entry with `root entry {
        if not self.token or self.token == "" {
            report {"error": "Token required", "success": false};
            return;
        }
        
        # Find user by token and clear token
        users = --> User;
        for user in users {
            if user.token == self.token {
                user.token = "";
                report {"success": true, "message": "Logged out successfully"};
                return;
            }
        }
        
        report {"success": true, "message": "Token already invalid"};
    }
    }

