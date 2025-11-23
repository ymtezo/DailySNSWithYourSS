/**
 * AlbumViewModel.ts
 * DailySNSWithYourSS Web版
 * 
 * アルバム閲覧のビジネスロジック
 */

import { Album } from '../models/User';
import { DataService } from '../services/DataService';

export class AlbumViewModel {
  private _albums: Album[] = [];
  private _selectedAlbum: Album | null = null;
  private _isLoading: boolean = false;
  private _errorMessage: string | null = null;
  private listeners: Set<() => void> = new Set();
  private dataService: DataService;

  constructor(dataService: DataService = new DataService()) {
    this.dataService = dataService;
  }

  get albums(): Album[] {
    return this._albums;
  }

  get selectedAlbum(): Album | null {
    return this._selectedAlbum;
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
   * アルバムを取得
   */
  async fetchAlbums(): Promise<void> {
    this._isLoading = true;
    this._errorMessage = null;
    this.notify();

    try {
      this._albums = await this.dataService.fetchAlbums();
    } catch (error) {
      this._errorMessage = error instanceof Error ? error.message : 'Unknown error';
    } finally {
      this._isLoading = false;
      this.notify();
    }
  }

  /**
   * アルバムを選択
   */
  selectAlbum(album: Album): void {
    this._selectedAlbum = album;
    this.notify();
  }

  /**
   * 選択をクリア
   */
  clearSelection(): void {
    this._selectedAlbum = null;
    this.notify();
  }
}
