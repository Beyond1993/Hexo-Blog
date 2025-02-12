---
title: DoorDash 5 mint Time Slot
date: 2025-02-12 12:30:59
categories: Interview
tags:
---


只有一道题：给 input （start_time， end_time）比如 ("mon 1:00 pm"， "tue 11:00 am")， output这其中所有的5min timestamp 前后都inclusive，其中每个timestamp format是变成一个5个digit的string。第一位数是星期（周一是1。。周日是7），后四位数是时间（23:55就是2355），所以 "mon 1:00 pm" 就是 “11300”
一个例子 ("mon 23:55 pm"， "tue 12:05 am") 就是output ["12355", "20000", "20005"]
可以assume input output time也都是 5min base，然后我的面试官口头说可以assume input valid

几个concern case：
* 注意是12:00 am,  12:05 am，好像也有12pm？lz一开始以为是00:00am。。
* 如果start_time 大于 end_time，一开始我以为output empty，后来我的面试官让我output：  start_time 到周日23:55，然后周一00到end_time
* 注意14：55 下一个是15:00， 然后周一23:55下一个是周二0:00. lz是在while loop里mod了一下那个output，如果结尾是2355 就 + （10000-2355），结尾是 55就加45


```python
from datetime import datetime, timedelta

class Solution:
    # Helper function to convert time string to a datetime object
    def parse_time(self, time_str: str) -> datetime:
        weekday_map = {
            'mon': 0, 'tue': 1, 'wed': 2, 'thu': 3, 'fri': 4, 'sat': 5, 'sun': 6
        }
        
        # Parse the time string to get weekday, time and am/pm info
        parts = time_str.split()
        day_of_week = parts[0]
        time_str = parts[1]
        
        # Check if it's AM/PM
        if len(parts) == 3:
            am_pm = parts[2].lower()
        else:
            am_pm = None  # No AM/PM, it's 24-hour time

        # Map weekday name to number (0 = Monday, 6 = Sunday)
        weekday = weekday_map[day_of_week.lower()]
        
        # Time parsing for 12-hour and 24-hour formats
        if am_pm:  # If there's AM/PM information (12-hour format)
            time_obj = datetime.strptime(time_str, "%I:%M")  # %I is 12-hour format with leading zeros
            # Adjust for AM/PM
            if am_pm == "pm" and time_obj.hour != 12:
                time_obj = time_obj.replace(hour=time_obj.hour + 12)
            elif am_pm == "am" and time_obj.hour == 12:
                time_obj = time_obj.replace(hour=0)
        else:  # If it's 24-hour format (no AM/PM)
            time_obj = datetime.strptime(time_str, "%H:%M")  # %H is 24-hour format

        # Adjust the datetime object to the correct day
        base_date = datetime(2023, 1, 1)  # Any arbitrary date
        base_date = base_date.replace(hour=time_obj.hour, minute=time_obj.minute, second=0, microsecond=0)
        # Adjust base_date to the correct weekday
        base_date += timedelta(days=(weekday - base_date.weekday()) % 7)
        return base_date
    
    # Helper function to format datetime to desired timestamp
    def format_timestamp(self, dt: datetime) -> str:
        weekday_map = {0: '1', 1: '2', 2: '3', 3: '4', 4: '5', 5: '6', 6: '7'}
        weekday = weekday_map[dt.weekday()]
        time_str = f"{dt.hour:02d}{dt.minute//5 * 5:02d}"  # Round down to nearest 5-minute mark
        return weekday + time_str
    
    def generate_time_stamps(self, start_time: str, end_time: str):
        # Parse start and end times into datetime objects
        start = self.parse_time(start_time)
        end = self.parse_time(end_time)
        
        # If the end time is before the start time, adjust by wrapping around the week
        if end < start:
            end += timedelta(days=7)  # Wrap around to next week
        
        timestamps = []
        current_time = start
        
        # Iterate over the time range in 5-minute intervals
        while current_time <= end:
            timestamps.append(self.format_timestamp(current_time))
            current_time += timedelta(minutes=5)
        
        return timestamps

# Example usage
solution = Solution()

# Test case 1: 12-hour format with PM
start_time = "mon 11:55 pm"
end_time = "tue 12:05 am"
result = solution.generate_time_stamps(start_time, end_time)
print(result)  # Expected output: ["12355", "20000", "20005"]

# Test case 2: 24-hour format
start_time = "mon 23:55"
end_time = "tue 00:05"
result = solution.generate_time_stamps(start_time, end_time)
print(result)  # Expected output: ["12355", "20000", "20005"]

# Test case 3: 12-hour format with AM
start_time = "wed 06:00 am"
end_time = "wed 06:25 am"
result = solution.generate_time_stamps(start_time, end_time)
print(result)  # Expected output: ["10600", "10605", "10610", "10615", "10620"]

# Test case 4: 24-hour format
start_time = "fri 14:30"
end_time = "fri 14:50"
result = solution.generate_time_stamps(start_time, end_time)
print(result)  # Expected output: ["51430", "51435", "51440", "51445", "51450"]

# Test case 5: Crossing over a week, 12-hour format
start_time = "sun 11:50 pm"
end_time = "mon 12:05 am"
result = solution.generate_time_stamps(start_time, end_time)
print(result)  # Expected output: ["71250", "80000", "80005"]

# Test case 6: Crossing over a week, 24-hour format
start_time = "sat 23:55"
end_time = "sun 00:05"
result = solution.generate_time_stamps(start_time, end_time)
print(result)  # Expected output: ["72355", "80000", "80005"]
```
