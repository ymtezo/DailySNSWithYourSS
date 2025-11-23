/**
 * PostCreationViewModel.ts
 * DailySNSWithYourSS Web版
 * 
 * 投稿作成のビジネスロジック
 */

import { Post, PostItem, PostItemType, createPost, createPostItem, getActiveItems } from '../models/Post';

export class PostCreationViewModel {
  private _postItems: PostItem[] = [];
  private _isCreatingPost: boolean = false;
  private _currentItemType: PostItemType = PostItemType.Screenshot;
  private listeners: Set<() => void> = new Set();

  get postItems(): PostItem[] {
    return this._postItems;
  }

  get isCreatingPost(): boolean {
    return this._isCreatingPost;
  }

  get currentItemType(): PostItemType {
    return this._currentItemType;
  }

  /**
   * 変更を監視
   */
  subscribe(listener: () => void): () => void {
    this.listeners.add(listener);
    return () => this.listeners.delete(listener);
  }

  private notify(): void {
    this.listeners.forEach(listener => listener());
  }

  /**
   * スクリーンショットを追加
   */
  addScreenshot(imageURL: string): void {
    const item = createPostItem(PostItemType.Screenshot, imageURL);
    this._postItems.push(item);
    this._currentItemType = PostItemType.Comment;
    this.notify();
  }

  /**
   * コメントを追加
   */
  addComment(text: string): void {
    if (!text.trim()) return;
    const item = createPostItem(PostItemType.Comment, text);
    this._postItems.push(item);
    this._currentItemType = PostItemType.Screenshot;
    this.notify();
  }

  /**
   * アイテムを削除（インデックス指定）
   */
  removeItemAt(index: number): void {
    if (index >= 0 && index < this._postItems.length) {
      this._postItems.splice(index, 1);
      this.notify();
    }
  }

  /**
   * アイテムを削除（ID指定）
   */
  removeItem(id: string): void {
    const index = this._postItems.findIndex(item => item.id === id);
    if (index !== -1) {
      this._postItems.splice(index, 1);
      this.notify();
    }
  }

  /**
   * アクティブなアイテムを取得
   */
  private getActiveItems(): PostItem[] {
    return this._postItems.filter(item => !item.isDeleted);
  }

  /**
   * 投稿を作成
   */
  createPost(userId: string): Post {
    const activeItems = this.getActiveItems();
    return createPost(userId, activeItems);
  }

  /**
   * リセット
   */
  reset(): void {
    this._postItems = [];
    this._currentItemType = PostItemType.Screenshot;
    this._isCreatingPost = false;
    this.notify();
  }

  /**
   * 投稿可能かチェック（最低1つのスクリーンショットが必要）
   */
  get canSubmit(): boolean {
    const activeItems = this.getActiveItems();
    return activeItems.some(item => item.type === PostItemType.Screenshot);
  }
}
