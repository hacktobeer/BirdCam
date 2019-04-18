import datetime
from onvif import ONVIFCamera

TZ = "CET+1CEST"
mycam = ONVIFCamera('192.168.86.219', 8899, 'admin', 'admin', '/home/pi/wsdl/')

# Get system date and time
date_now = datetime.datetime.utcnow()
dt = mycam.devicemgmt.GetSystemDateAndTime()
tz = dt.TimeZone
year = str(dt.UTCDateTime.Date.Year)
month = str(dt.UTCDateTime.Date.Month)
day = str(dt.UTCDateTime.Date.Day)
hour = str(dt.UTCDateTime.Time.Hour)
minute = str(dt.UTCDateTime.Time.Minute)
second = str(dt.UTCDateTime.Time.Second)

# Create datetime object from string
date_str = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second 
date_time_obj = datetime.datetime.strptime(date_str, '%Y-%m-%d %H:%M:%S')

# Calculate time difference in seconds and set system time if > 10 seconds
time_diff = int((date_time_obj-date_now).total_seconds())
if time_diff > 10 or time_diff < -10:
	print "time diff("+str(time_diff)+") too big, let's sync"

	time_params = mycam.devicemgmt.create_type('SetSystemDateAndTime')
	time_params.DateTimeType = 'Manual'
	time_params.DaylightSavings = True
	time_params.TimeZone.TZ = TZ 
	time_params.UTCDateTime.Date.Year = date_now.year
	time_params.UTCDateTime.Date.Month = date_now.month
	time_params.UTCDateTime.Date.Day = date_now.day 
	time_params.UTCDateTime.Time.Hour = date_now.hour 
	time_params.UTCDateTime.Time.Minute = date_now.minute 
	time_params.UTCDateTime.Time.Second = date_now.second 
	mycam.devicemgmt.SetSystemDateAndTime(time_params)
