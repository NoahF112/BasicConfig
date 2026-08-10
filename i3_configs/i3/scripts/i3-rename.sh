#!/usr/bin/env bash

# 1. 获取当前聚焦的工作区编号
WORK_NUM=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).num')

# 2. 使用 rofi 弹出纯净的输入框
NEW_NAME=$(rofi -dmenu -p "Rename Workspace $WORK_NUM to")

# 3. 如果输入不为空，则重命名
if [ -n "$NEW_NAME" ]; then
    i3-msg "rename workspace to \"$WORK_NUM: $NEW_NAME\""
fi

