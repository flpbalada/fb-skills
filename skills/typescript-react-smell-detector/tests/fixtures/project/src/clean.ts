export interface User {
  id: string;
}

export const getUserId = (user: User) => user.id;
