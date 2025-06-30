#!/bin/bash

# 检查是否有变更
if [ -z "$(git status --porcelain)" ]; then
    echo "没有检测到文件变更，无需提交"
    exit 0
fi

# 生成提交信息
if [ $# -eq 1 ]; then
    # 如果提供了自定义提交信息，使用它
    msg="$1"
else
    # 自动生成提交信息
    echo "正在分析文件变更..."
    
    # 获取变更的文件列表
    changed_files=$(git status --porcelain | head -10)
    added_files=$(git status --porcelain | grep "^A" | wc -l | tr -d ' ')
    modified_files=$(git status --porcelain | grep "^M" | wc -l | tr -d ' ')
    deleted_files=$(git status --porcelain | grep "^D" | wc -l | tr -d ' ')
    
    # 构建提交信息
    msg="docs: "
    
    if [ "$added_files" -gt 0 ]; then
        msg="${msg}新增${added_files}个文件"
    fi
    
    if [ "$modified_files" -gt 0 ]; then
        if [ "$added_files" -gt 0 ]; then
            msg="${msg}，"
        fi
        msg="${msg}修改${modified_files}个文件"
    fi
    
    if [ "$deleted_files" -gt 0 ]; then
        if [ "$added_files" -gt 0 ] || [ "$modified_files" -gt 0 ]; then
            msg="${msg}，"
        fi
        msg="${msg}删除${deleted_files}个文件"
    fi
    
    # 如果有具体的章节变更，添加到提交信息中
    chapter_changes=$(git status --porcelain | grep -E "chapter[0-9]+/" | head -3)
    if [ ! -z "$chapter_changes" ]; then
        chapters=$(echo "$chapter_changes" | sed 's/.*chapter\([0-9]\+\).*/\1/' | sort -u | tr '\n' ',' | sed 's/,$//')
        msg="${msg} (涉及章节: ${chapters})"
    fi
fi

echo "提交信息: $msg"

# 添加所有变更
git add -A

# 提交变更
git commit -m "$msg"

if [ $? -eq 0 ]; then
    echo "提交成功，开始推送到远程仓库..."
    
    # 推送到主仓库
    echo "推送到 origin master..."
    git push origin master
    
    # 检查其他远程仓库是否存在，如果存在则推送
    if git remote | grep -q "gitee"; then
        echo "推送到 gitee..."
        git push gitee master 2>/dev/null || echo "gitee 推送失败或分支不存在"
    fi
    
    if git remote | grep -q "github"; then
        echo "推送到 github..."
        git push github master 2>/dev/null || echo "github 推送失败或分支不存在"
    fi
    
    if git remote | grep -q "gitcode"; then
        echo "推送到 gitcode..."
        git push gitcode master 2>/dev/null || echo "gitcode 推送失败或分支不存在"
    fi
    
    echo "部署完成！"
else
    echo "提交失败，请检查错误信息"
    exit 1
fi



