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
  echo "[1/6] Homebrew をインストール中..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple Silicon (M1/M2/M3) の場合、Homebrewのパスが /opt/homebrew になる
  # Intel Macの場合は /usr/local なので、どちらでも動くように両方チェックする
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "[1/6] Homebrew はインストール済みです。スキップします。"
fi

# ─────────────────────────────────────────────
# 2. dotfilesリポジトリのクローン
# ─────────────────────────────────────────────
# `-d` でディレクトリが存在するか確認できる
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "[2/6] dotfiles をクローン中..."
  # `mkdir -p` は中間のディレクトリ（workspaces）も含めて一括作成する
  # `-p` なしだと親ディレクトリが存在しない場合にエラーになる
  mkdir -p "$HOME/workspaces"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "[2/6] dotfiles はすでに存在します。最新の状態に更新中..."
  # `-C` オプションでcdせずに特定ディレクトリのgit操作ができる
  git -C "$DOTFILES_DIR" pull
fi

# ─────────────────────────────────────────────
# 3. Homebrew パッケージの一括インストール
# ─────────────────────────────────────────────
# `brew bundle` はBrewfileに書かれたツール・アプリを一括インストールするコマンド
# `--file` でBrewfileの場所を指定している
echo "[3/6] Homebrew パッケージをインストール中（時間がかかります）..."
# 一部のパッケージが失敗しても後続のステップを止めないよう set -e を一時解除する
# brew bundle は個別のインストール失敗があると非0を返すため
set +e
brew bundle --file="$DOTFILES_DIR/Brewfile"
set -e

# ─────────────────────────────────────────────
# 4. シンボリックリンクの作成
# ─────────────────────────────────────────────
# シンボリックリンク = ファイルの「ショートカット」
# dotfilesリポジトリのファイルをホームディレクトリから参照できるようにする
# こうすることで、設定ファイルをgitで一元管理できる
echo "[4/6] シンボリックリンクを作成中..."

# リンク作成の処理を関数にまとめている
# 同じ処理を何度も書かずに済む（DRY原則）
link() {
  local src="$1"  # リンク元（dotfiles内のファイル）
  local dst="$2"  # リンク先（ホームディレクトリ等）

  # すでに通常ファイル/ディレクトリとして存在する場合はバックアップして上書き
  # `-e` はファイル/ディレクトリが存在するか、`-L` はシンボリックリンクか
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  バックアップ: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  # 既存のシンボリックリンクを先に削除してから作成する
  # `ln -sf` はリンク先がディレクトリへのシンボリックリンクの場合、その中にリンクを作ってしまうため
  [ -L "$dst" ] && rm "$dst"
  ln -s "$src" "$dst"
  echo "  作成: $dst -> $src"
}

# iTerm2 の設定はシンボリックリンクではなく defaults write で管理する
# iTerm2 は起動時に ~/Library/Preferences/com.googlecode.iterm2.plist を実ファイルで上書きするため
# symlink を張ってもすぐに壊れてしまう。代わりに PrefsCustomFolder を指定する方式を使う
defaults write com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES_DIR/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
echo "  iTerm2: PrefsCustomFolder を $DOTFILES_DIR/iterm2 に設定"

# ~/.config/zsh/ 配下のPrezto設定ファイル群をリンクする
# ZDOTDIRを ~/.config/zsh に向けているため、Preztoの設定はここに集約されている
mkdir -p "$HOME/.config/zsh"
link "$DOTFILES_DIR/zsh/.zshenv"    "$HOME/.config/zsh/.zshenv"
link "$DOTFILES_DIR/zsh/.zshrc"     "$HOME/.config/zsh/.zshrc"
link "$DOTFILES_DIR/zsh/.zlogin"    "$HOME/.config/zsh/.zlogin"
link "$DOTFILES_DIR/zsh/.zlogout"   "$HOME/.config/zsh/.zlogout"
link "$DOTFILES_DIR/zsh/.zprofile"  "$HOME/.config/zsh/.zprofile"
# Prezto 本体は dotfiles に含めず公式リポジトリから clone する
# git サブモジュール（pure テーマなど）が必要なため --recursive オプションを使う
if [ ! -d "$HOME/.config/zsh/.zprezto" ]; then
  echo "  Prezto をインストール中..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.config/zsh/.zprezto"
else
  echo "  Prezto はインストール済みです。スキップします。"
fi
link "$DOTFILES_DIR/zsh/.zpreztorc" "$HOME/.config/zsh/.zpreztorc"

# git-prompt.sh をダウンロードする
# zshrc で source しているが dotfiles には含めず公式リポジトリから取得する
if [ ! -f "$HOME/.git-completion/git-prompt.sh" ]; then
  echo "  git-prompt.sh をダウンロード中..."
  mkdir -p "$HOME/.git-completion"
  curl -fsSL "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh" \
    -o "$HOME/.git-completion/git-prompt.sh"
else
  echo "  git-prompt.sh はインストール済みです。スキップします。"
fi

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

# Karabiner-Elements のキーバインド設定
mkdir -p "$HOME/.config/karabiner"
link "$DOTFILES_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# ─────────────────────────────────────────────
# 5. Claude Code（秘書くん）の設定を復元
# ─────────────────────────────────────────────
# 設定ファイルの実体は Obsidian vault（~/Documents/ksmxxxxxx/claude-config/）に置いてある
# Obsidian Sync で新PCに届いたファイルをシンボリックリンクで参照する構成になっている
# こうすることで、設定の変更が自動的に Sync で他のPCにも反映される
#
# 【前提】このステップを実行する前に Obsidian Sync が完了していること
# 同期が終わっていないと vault のファイルが存在せず、リンクが壊れた状態になる
CLAUDE_CONFIG_DIR="$HOME/Documents/ksmxxxxxx/claude-config"

echo "[5/6] Claude Code の設定を復元中..."

if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
  echo "  スキップ: $CLAUDE_CONFIG_DIR が見つかりません。Obsidian Sync が完了しているか確認してください。"
else
  # ~/.claude/ ディレクトリが存在しない場合は作成する
  # Claude Code を一度も起動していない新PCでは存在しないことがある
  mkdir -p "$HOME/.claude"

  # memory のリンク先ディレクトリを事前に作成しておく
  # Claude Code が自動生成するパスなので、初回起動前は存在しない
  mkdir -p "$HOME/.claude/projects/-Users-kasumi-suzuki-workspaces"

  link "$CLAUDE_CONFIG_DIR/settings.json" "$HOME/.claude/settings.json"
  link "$CLAUDE_CONFIG_DIR/claude.json"   "$HOME/.claude.json"
  link "$CLAUDE_CONFIG_DIR/CLAUDE.md"     "$HOME/CLAUDE.md"
  link "$CLAUDE_CONFIG_DIR/memory"        "$HOME/.claude/projects/-Users-kasumi-suzuki-workspaces/memory"
fi

# ─────────────────────────────────────────────
# 6. NeoVim プラグインのインストール
# ─────────────────────────────────────────────
# `--headless` = GUIを起動せずにNeoVimを実行するオプション
# `"+Lazy! sync"` = lazy.nvimのsyncコマンドを起動時に実行する
# `+qa` = 処理が終わったらNeoVimを終了する
echo "[6/6] NeoVim プラグインをインストール中..."
nvim --headless "+Lazy! sync" +qa 2>&1

echo ""
echo "===== セットアップ完了！ ====="
echo ""
echo "次のステップ："
echo "  1. ターミナルを再起動するか、以下を実行してzshを再読み込み："
echo "     exec zsh"
echo ""
echo "  2. rbenv で Ruby をセットアップ（ruby-lsp に必要）："
echo "     rbenv install 3.3.9  # インストール済みの場合はスキップ"
echo "     rbenv global 3.3.9"
echo ""
echo "  3. nodenv で Node 22 をセットアップ（Copilot・各種 LSP に必要）："
echo "     nodenv install 22.14.0  # インストール済みの場合はスキップ"
echo "     nodenv global 22.14.0"
echo ""
echo "  4. NeoVim プラグイン・LSP サーバーのインストール："
echo "     nvim → :Lazy sync"
echo ""
echo "  5. GitHub Copilot の認証（NeoVim内で実行）："
echo "     :Copilot auth"
echo ""
echo "  6. Claude Code の認証："
echo "     claude"
echo ""
echo "  7. Figma API キーを Keychain に登録（Claude Code の Figma MCP に必要）："
echo "     security add-generic-password -a \"\$USER\" -s FIGMA_API_TOKEN -w"
