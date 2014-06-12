(function ($) {
        $.fn.simpleClock = function () {

        // Define weekdays and months
        var weekdays = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"]
        var months = ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"];

        // getTime - Where the magic happens ...
        function getTime() {
                var date = new Date(),
                hour = date.getHours();
                return {
                        day: weekdays[date.getDay()],
                        date: date.getDate(),
                        month: months[date.getMonth()],
                        hour: appendZero(hour),
                        minute: appendZero(date.getMinutes()),
                        second: appendZero(date.getSeconds())
                };
        }

        // appendZero - If the number is less than 10, add a leading zero.
        function appendZero(num) {
                if (num < 10) {
                        return "0" + num;
                }
                return num;
        }

        // refreshTime - Build the clock.
        function refreshTime() {
                var now = getTime();
                $('#date').html(now.day + ', ' + now.date + '. ' + now.month);
                $('#time').html(now.hour + ":" + now.minute + ":" + now.second + " Uhr");
        }

        // Tick tock - Run the clock.
        refreshTime();
        setInterval(refreshTime, 1000);
        };
})(jQuery);

$(document).ready(function() {
        $("#clock").simpleClock();
        setInterval('updateClock()', 1000);
});