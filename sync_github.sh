#!/bin/bash

# 检查参数
if [ -z "\$1" ]; then
  echo "提交信息不能为空!"
  exit 1
fi

# 获取远程仓库（推送地址）
remote_repository=$(git remote -v | grep push | awk '{print \$1}')

# 获取当前分支
current_branch=$(git branch | grep '*' | awk '{print \$2}')

# 添加所有更改
git add .

# 提交更改，提交信息为第一个参数
if ! git commit -m "\$1"; then
  echo "提交失败！"
  exit 1
fi

# 推送更改到远程仓库的当前分支
if ! git push "$remote_repository" "$current_branch"; then
  echo "推送失败！"
  exit 1
fi

echo "提交成功！"