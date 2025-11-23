/**
 * Post.ts
 * DailySNSWithYourSS Web版
 * 
 * 投稿とアイテムのデータモデル
 */

export enum PostItemType {
  Screenshot = 'screenshot',
  Comment = 'comment'
}

export interface PostItem {
  id: string;
  type: PostItemType;
  content: string; // Image URL for screenshot, text for comment
  timestamp: Date;
  isDeleted: boolean;
}

export interface Post {
  id: string;
  userId: string;
  items: PostItem[];
  createdAt: Date;
  updatedAt: Date;
}

/**
 * PostItemを作成
 */
export function createPostItem(
  type: PostItemType,
  content: string,
  id?: string,
  timestamp?: Date
): PostItem {
  return {
    id: id || crypto.randomUUID(),
    type,
    content,
    timestamp: timestamp || new Date(),
    isDeleted: false
  };
}

/**
 * Postを作成
 */
export function createPost(
  userId: string,
  items: PostItem[] = [],
  id?: string,
  createdAt?: Date,
  updatedAt?: Date
): Post {
  const now = new Date();
  return {
    id: id || crypto.randomUUID(),
    userId,
    items,
    createdAt: createdAt || now,
    updatedAt: updatedAt || now
  };
}

/**
 * アクティブなアイテム（削除されていない）を取得
 */
export function getActiveItems(post: Post): PostItem[] {
  return post.items.filter(item => !item.isDeleted);
}
