$(function() {
    $('#datetimepicker1').datetimepicker({format: 'MMMM Do YYYY hh:mm a', minDate: moment(),maxDate: moment().add(7, 'days')});
});
$(function() {
    $('#datetimepicker2').datetimepicker({format: 'MMMM Do YYYY, hh:mm a', minDate: moment().add(1, 'minute'),maxDate: moment().add(7, 'days')});
});
$(function() {
    $('#datetimepicker3').datetimepicker({format: 'MMMM Do YYYY, hh:mm a', minDate: moment(),maxDate: moment().add(7, 'days')});
});
$(function() {
    $('#datetimepicker4').datetimepicker({format: 'MMMM Do YYYY, hh:mm a', minDate: moment(),maxDate: moment().add(7, 'days')});
});