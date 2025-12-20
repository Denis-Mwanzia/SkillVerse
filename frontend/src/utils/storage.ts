/**
 * Secure token storage utility
 * Provides type-safe, error-handled access to localStorage for authentication tokens
 */

const TOKEN_KEYS = {
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token',
} as const;

type TokenKey = typeof TOKEN_KEYS[keyof typeof TOKEN_KEYS];

class TokenStorage {
  private isAvailable(): boolean {
    try {
      const test = '__storage_test__';
      localStorage.setItem(test, test);
      localStorage.removeItem(test);
      return true;
    } catch {
      return false;
    }
  }

  private safeGet(key: TokenKey): string | null {
    if (!this.isAvailable()) {
      return null;
    }

    try {
      return localStorage.getItem(key);
    } catch (error) {
      // Log but don't throw - allow app to continue
      console.warn(`Failed to get ${key} from localStorage:`, error);
      return null;
    }
  }

  private safeSet(key: TokenKey, value: string): boolean {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      localStorage.setItem(key, value);
      return true;
    } catch (error) {
      // Log but don't throw - allow app to continue
      console.warn(`Failed to set ${key} in localStorage:`, error);
      return false;
    }
  }

  private safeRemove(key: TokenKey): boolean {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      localStorage.removeItem(key);
      return true;
    } catch (error) {
      // Log but don't throw - allow app to continue
      console.warn(`Failed to remove ${key} from localStorage:`, error);
      return false;
    }
  }

  getAccessToken(): string | null {
    return this.safeGet(TOKEN_KEYS.ACCESS_TOKEN);
  }

  getRefreshToken(): string | null {
    return this.safeGet(TOKEN_KEYS.REFRESH_TOKEN);
  }

  setAccessToken(token: string): boolean {
    return this.safeSet(TOKEN_KEYS.ACCESS_TOKEN, token);
  }

  setRefreshToken(token: string): boolean {
    return this.safeSet(TOKEN_KEYS.REFRESH_TOKEN, token);
  }

  setTokens(accessToken: string, refreshToken: string): boolean {
    const accessSuccess = this.setAccessToken(accessToken);
    const refreshSuccess = this.setRefreshToken(refreshToken);
    return accessSuccess && refreshSuccess;
  }

  removeAccessToken(): boolean {
    return this.safeRemove(TOKEN_KEYS.ACCESS_TOKEN);
  }

  removeRefreshToken(): boolean {
    return this.safeRemove(TOKEN_KEYS.REFRESH_TOKEN);
  }

  clearTokens(): void {
    this.removeAccessToken();
    this.removeRefreshToken();
  }

  hasTokens(): boolean {
    return this.getAccessToken() !== null && this.getRefreshToken() !== null;
  }
}

export const tokenStorage = new TokenStorage();

