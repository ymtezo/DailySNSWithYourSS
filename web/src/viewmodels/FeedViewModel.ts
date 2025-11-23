/**
 * FeedViewModel.ts
 * DailySNSWithYourSS Web版
 * 
 * フィード表示のビジネスロジック
 */

import { Post } from '../models/Post';
import { DataService } from '../services/DataService';

export enum FeedType {
  Following = 'following',
  Global = 'global'
}

export class FeedViewModel {
  private _posts: Post[] = [];
  private _feedType: FeedType = FeedType.Following;
  private _isLoading: boolean = false;
  private _errorMessage: string | null = null;
  private listeners: Set<() => void> = new Set();
  private dataService: DataService;
  private currentUserId: string;

  constructor(currentUserId: string, dataService: DataService = new DataService()) {
    this.currentUserId = currentUserId;
    this.dataService = dataService;
  }

  get posts(): Post[] {
    return this._posts;
  }

  get feedType(): FeedType {
    return this._feedType;
  }

  get isLoading(): boolean {
    return this._isLoading;
  }

  get errorMessage(): string | null {
    return this._errorMessage;
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
   * 投稿を取得
   */
  async fetchPosts(): Promise<void> {
    this._isLoading = true;
    this._errorMessage = null;
    this.notify();

    try {
      if (this._feedType === FeedType.Following) {
        this._posts = await this.dataService.fetchRandomFollowingPosts(this.currentUserId);
      } else {
        this._posts = await this.dataService.fetchRandomGlobalPosts();
      }
    } catch (error) {
      this._errorMessage = error instanceof Error ? error.message : 'Unknown error';
    } finally {
      this._isLoading = false;
      this.notify();
    }
  }

  /**
   * フィードタイプを切り替え
   */
  async switchFeedType(type: FeedType): Promise<void> {
    if (this._feedType === type) return;
    this._feedType = type;
    await this.fetchPosts();
  }

  /**
   * 更新
   */
  async refresh(): Promise<void> {
    await this.fetchPosts();
  }
}
