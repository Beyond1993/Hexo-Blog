---
title: Python-Time
date: 2025-04-10 10:29:41
categories: Python
tags:
---

```python
from datetime import datetime

# 常用格式及示例
examples = [
    # 年月日
    ("2025-04-09", "%Y-%m-%d"),
    ("25-04-09", "%y-%m-%d"),

    # 月/日/年（美式）
    ("04/09/2025", "%m/%d/%Y"),

    # 带时间（24小时制）
    ("2025-04-09 14:30:45", "%Y-%m-%d %H:%M:%S"),

    # 带时间（12小时制 + AM/PM）—— %I 用例
    ("04/09/2025 02:30:45 PM", "%m/%d/%Y %I:%M:%S %p"),
    ("04/09/2025 07:15:00 AM", "%m/%d/%Y %I:%M:%S %p"),

    # 只有时间（12小时制）
    ("02:45:30 PM", "%I:%M:%S %p"),
    ("07:15:00 AM", "%I:%M:%S %p"),

    # 全文日期格式
    ("Wednesday, April 09, 2025 02:30 PM", "%A, %B %d, %Y %I:%M %p"),

    # ISO 8601 格式
    ("2025-04-09T14:30:45", "%Y-%m-%dT%H:%M:%S"),

    # 年的第几天
    ("2025-099", "%Y-%j"),
]

# 示例运行
for date_str, fmt in examples:
    dt = datetime.strptime(date_str, fmt)
    print(f"{date_str}  =>  {dt}")
```


| 格式代码 | 含义                   | 示例         |
|----------|------------------------|--------------|
| `%Y`     | 四位数年份             | `2025`       |
| `%y`     | 两位数年份             | `25`         |
| `%m`     | 月（01–12）            | `04`         |
| `%d`     | 日（01–31）            | `09`         |
| `%H`     | 小时（24 小时制）      | `14`         |
| `%I`     | 小时（12 小时制）      | `02`         |
| `%M`     | 分钟（00–59）          | `30`         |
| `%S`     | 秒（00–59）            | `45`         |
| `%f`     | 微秒（000000–999999）  | `123456`     |
| `%p`     | AM / PM                | `PM`         |
| `%a`     | 星期名（缩写）         | `Wed`        |
| `%A`     | 星期名（全称）         | `Wednesday`  |
| `%b`     | 月名（缩写）           | `Apr`        |
| `%B`     | 月名（全称）           | `April`      |
| `%j`     | 一年中的第几天（001–366）| `099`      |
| `%U`     | 周数（星期天为一周的开始）| `14`      |
| `%W`     | 周数（星期一为一周的开始）| `14`      |
| `%c`     | 本地日期和时间表示     | `Wed Apr 9 14:30:45 2025` |
| `%x`     | 本地日期表示           | `04/09/2025` |
| `%X`     | 本地时间表示           | `14:30:45`   |
| `%z`     | UTC 偏移（±HHMM）      | `+0800`      |
| `%Z`     | 时区缩写               | `UTC`        |
| `%%`     | 字面值 `%` 符号        | `%`          |



