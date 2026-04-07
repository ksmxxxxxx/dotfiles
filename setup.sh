#!/bin/bash

# エラーが起きたらスクリプトを即座に停止する
# set -e をつけないとコマンドが失敗しても処理が続いてしまう
set -e

# dotfilesを置く場所とGitHubのURLを変数として定義しておく
# 変数にすると、後で変更するときに1か所直すだけで済む
DOTFILES_DIR="$HOME/workspaces/dotfiles"
DOTFILES_REPO="https://github.com/ksmxxxxxx/dotfiles"

echo "===== dotfiles セットアップ開始 ====="

# ─────────────────────────────────────────────
# 1. Homebrewのインストール
# ─────────────────────────────────────────────
# `command -v brew` でbrewコマンドが存在するか確認する
# `&>/dev/null` は標準出力・エラー出力を両方捨てる（画面に出力しない）という意味
if ! command -v brew &>/dev/null; then
  echo "[1/5] Homebrew をインストール中..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple Silicon (M1/M2/M3) の場合、Homebrewのパスが /opt/homebrew になる
  # Intel Macの場合は /usr/local なので、どちらでも動くように両方チェックする
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "[1/5] Homebrew はインストール済みです。スキップします。"
fi

# ─────────────────────────────────────────────
# 2. dotfilesリポジトリのクローン
# ─────────────────────────────────────────────
# `-d` でディレクトリが存在するか確認できる
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "[2/5] dotfiles をクローン中..."
  # `mkdir -p` は中間のディレクトリ（workspaces）も含めて一括作成する
  # `-p` なしだと親ディレクトリが存在しない場合にエラーになる
  mkdir -p "$HOME/workspaces"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "[2/5] dotfiles はすでに存在します。最新の状態に更新中..."
  # `-C` オプションでcdせずに特定ディレクトリのgit操作ができる
  git -C "$DOTFILES_DIR" pull
fi

# ─────────────────────────────────────────────
# 3. Homebrew パッケージの一括インストール
# ─────────────────────────────────────────────
# `brew bundle` はBrewfileに書かれたツール・アプリを一括インストールするコマンド
# `--file` でBrewfileの場所を指定している
echo "[3/5] Homebrew パッケージをインストール中（時間がかかります）..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ─────────────────────────────────────────────
# 4. シンボリックリンクの作成
# ─────────────────────────────────────────────
# シンボリックリンク = ファイルの「ショートカット」
# dotfilesリポジトリのファイルをホームディレクトリから参照できるようにする
# こうすることで、設定ファイルをgitで一元管理できる
echo "[4/5] シンボリックリンクを作成中..."

# リンク作成の処理を関数にまとめている
# 同じ処理を何度も書かずに済む（DRY原則）
link() {
  local src="$1"  # リンク元（dotfiles内のファイル）
  local dst="$2"  # リンク先（ホームディレクトリ等）

  # すでに通常ファイルとして存在する場合はスキップ（上書き事故を防ぐ）
  # `-e` はファイル/ディレクトリが存在するか、`-L` はシンボリックリンクか
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  スキップ: $dst はすでに存在します（手動で確認してください）"
    return
  fi

  # `ln -sf` でシンボリックリンクを作成する
  # `-s` = シンボリックリンク、`-f` = すでにリンクがあっても上書きする
  ln -sf "$src" "$dst"
  echo "  作成: $dst -> $src"
}

link "$DOTFILES_DIR/.zshrc"               "$HOME/.zshrc"
link "$DOTFILES_DIR/.zshenv"              "$HOME/.zshenv"
link "$DOTFILES_DIR/.tmux.conf"           "$HOME/.tmux.conf"
link "$DOTFILES_DIR/.tigrc"               "$HOME/.tigrc"
link "$DOTFILES_DIR/.gitconfig"           "$HOME/.gitconfig"
link "$DOTFILES_DIR/.gitignore_global"    "$HOME/.gitignore_global"
link "$DOTFILES_DIR/.git_commit_template" "$HOME/.git_commit_template"

# ~/.config/nvim はディレクトリごとリンクする
# `mkdir -p` で ~/.config が存在しない場合も安全に作成できる
mkdir -p "$HOME/.config"
link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# ─────────────────────────────────────────────
# 5. NeoVim プラグインのインストール
# ─────────────────────────────────────────────
# `--headless` = GUIを起動せずにNeoVimを実行するオプション
# `"+Lazy! sync"` = lazy.nvimのsyncコマンドを起動時に実行する
# `+qa` = 処理が終わったらNeoVimを終了する
echo "[5/5] NeoVim プラグインをインストール中..."
nvim --headless "+Lazy! sync" +qa 2>&1

echo ""
echo "===== セットアップ完了！ ====="
echo ""
echo "次のステップ："
echo "  1. ターミナルを再起動するか、以下を実行してzshを再読み込み："
echo "     exec zsh"
echo ""
echo "  2. GitHub Copilot の認証（NeoVim内で実行）："
echo "     :Copilot auth"
echo ""
echo "  3. nodenv で Node 22 をインストール（Copilot に必要）："
echo "     nodenv install 22.14.0"
echo ""
echo "  4. Claude Code の認証："
echo "     claude"
