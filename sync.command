#!/bin/bash
# Dofoto PRD 一键同步脚本
# 双击运行：自动 commit + push 当前所有改动到 GitHub Pages
# 部署延迟约 30 秒~2 分钟

cd "$(dirname "$0")" || exit 1

echo "================================================"
echo "  Dofoto PRD 同步到 GitHub Pages"
echo "================================================"
echo ""

# 1. 检查有无改动
if [ -z "$(git status --porcelain)" ]; then
  echo "✓ 当前没有待同步的改动。"
  echo ""
  echo "（如果你刚刚改了 HTML 但这里显示没改动，可能是没保存。先 Cmd+S 保存再跑此脚本。）"
  echo ""
  read -p "按回车关闭..."
  exit 0
fi

# 2. 展示要同步的文件
echo "📝 待同步的改动："
echo "------------------------------------------------"
git status --short
echo "------------------------------------------------"
echo ""

# 3. 让用户输入 commit message（可跳过用默认值）
read -p "输入本次改动的一句话说明（直接回车用默认值）: " msg
if [ -z "$msg" ]; then
  msg="update PRD $(date +'%Y-%m-%d %H:%M')"
fi

# 4. 执行 git add + commit + push
echo ""
echo "⏳ 正在同步..."
git add -A
git commit -m "$msg"

if git push; then
  echo ""
  echo "================================================"
  echo "  ✅ 同步成功"
  echo "================================================"
  echo ""
  echo "🌐 在线访问："
  echo "   https://crystal310.github.io/dofoto-prd-share/"
  echo ""
  echo "⏱  GitHub Pages 约 30 秒~2 分钟后更新生效。"
  echo "   开发刷新页面即看最新版。"
  echo ""
else
  echo ""
  echo "❌ 推送失败。可能是网络问题，请重试一次。"
  echo "   如果反复失败，检查 GitHub 登录状态："
  echo "   gh auth status"
  echo ""
fi

read -p "按回车关闭..."
