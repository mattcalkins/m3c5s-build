export default function generateTimestampTag() {
    const pad = (num, size) => String(num).padStart(size, '0');
    const date = new Date();
    const year = date.getFullYear();
    const month = pad(date.getMonth() + 1, 2);
    const day = pad(date.getDate(), 2);
    const hours = pad(date.getHours(), 2);
    const minutes = pad(date.getMinutes(), 2);
    const seconds = pad(date.getSeconds(), 2);
    const milliseconds = pad(date.getMilliseconds(), 3);

    // Get time zone offset
    const timeZoneOffset = -date.getTimezoneOffset();
    const timeZoneSign = timeZoneOffset >= 0 ? 'p' : 'm'; // 'p' for '+', 'm' for '-'
    const timeZoneHours = pad(Math.floor(Math.abs(timeZoneOffset) / 60), 2);
    const timeZoneMinutes = pad(Math.abs(timeZoneOffset) % 60, 2);
    const timeZone = `${timeZoneSign}${timeZoneHours}${timeZoneMinutes}`;

    const dateString = `${year}-${month}-${day}--${hours}-${minutes}-${seconds}-${milliseconds}--${timeZone}`;

    return dateString;
}
