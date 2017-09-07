<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>풀캘린더::구글캘린더</title>
<style type="text/css">
    body {
        margin:40px 10px;
        padding:0;
        font-family:"Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
        font-size:14px;
    }

    #loading {
        display:none;
        position:absolute;
        top:10px;
        right:10px;
    }

    #calendar {
        max-width:900px;
        margin:0 auto;
    }

    div.barKategorie {
        float:left;
        margin:5px;
        padding-top:5px;
        padding-bottom:5px;
        padding-left:5px;
        padding-right:10px;
        border-radius:5px;
        font-weight:bold;
    }
</style>
<link href="/fullcalendar-3.3.1/fullcalendar.css" rel="stylesheet"/>
<link href="/fullcalendar-3.3.1/fullcalendar.print.css" rel="stylesheet" media="print"/>
<script type="text/javascript" src="/fullcalendar-3.3.1/lib/moment.min.js"></script>
<script type="text/javascript" src="/fullcalendar-3.3.1/lib/jquery.min.js"></script>
<script type="text/javascript" src="/fullcalendar-3.3.1/fullcalendar.js" charset="euc-kr"></script>
<script type="text/javascript" src="/fullcalendar-3.3.1/gcal.js"></script>
<script type="text/javascript" src="/fullcalendar-3.3.1/locale-all.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
            header : {
                  left : "prev"
                , center : "title, month"
                , right : "next"
            }
            , lang : "ko"
            , editable : true
            , eventLimit : true

            , googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"      // Google API KEY

            




, googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"      // Google API KEY

            // 예제소스에 적힌 구글캘린더 API 키는 FullCalendar 예제에 있는 API키를 그대로 사용한 것이다.


            , googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"
            , eventSources : [
                // 대한민국의 공휴일
                {
                      googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
                    , className : "koHolidays"
                    , color : "#FF0000"
                    , textColor : "#FFFFFF"
                }
                // 미국의 공휴일
                , {
                      googleCalendarId : "ko.usa#holiday@group.v.calendar.google.com"
                    , className : "usaHolidays"
                    , color : "#0000FF"
                    , textColor : "#FFFF00"
                }
                // 일본의 공휴일
                , {
                      googleCalendarId : "ko.japanese#holiday@group.v.calendar.google.com"
                    , className : "jpHolidays"
                    , color : "#FF99CC"
                    , textColor : "#000000"
                }
            ]
            , loading:function(bool) {
                jQuery("#loading").toggle(bool);
            }
        });
    });

    // addEventSource, removeEventSource의 기능하는데 구별값은 googleCalendarId 이다.
    // 그렇기에 googleCalendarId는 반드시 입력해야한다.
    function scheduleChoice(num, id, distinct, color, text) {
        if(jQuery(".swingBar").eq(num).is(":checked")) {
            jQuery("#calendar").fullCalendar("addEventSource", { googleCalendarId : id, className : distinct, color : color, textColor : text });
        } else {
            jQuery("#calendar").fullCalendar("removeEventSource", { googleCalendarId : id });
        }
    }
</script>
<body>
    <div style="width:100%;display:table-cell;float:center;">
        <div class="barKategorie" style="background-color:#FF0000;color:#FFFFFF;">
            <label>
                <input type="checkbox" class="swingBar" onChange="scheduleChoice(0, 'ko.south_korea#holiday@group.v.calendar.google.com', 'usaHolidays', '#FF0000', '#FFFFFF');" checked/>
                &nbsp;한국 공휴일
            </label>
        </div>
        <div class="barKategorie" style="background-color:#0000FF;color:#FFFF00;">
            <label>
                <input type="checkbox" class="swingBar" onChange="scheduleChoice(1, 'ko.usa#holiday@group.v.calendar.google.com', 'usaHolidays', '#0000FF', '#FFFF00');" checked/>
                &nbsp;미국 공휴일
            </label>
        </div>
        <div class="barKategorie" style="background-color:#FF99CC;color:#000000;">
            <label>
                <input type="checkbox" class="swingBar" onChange="scheduleChoice(2, 'ko.japanese#holiday@group.v.calendar.google.com', 'jpHolidays', '#FF99CC', '#000000');" checked/>
                &nbsp;일본 공휴일
            </label>
        </div>
    </div>
    <div style="height:30px;"></div>
    <div id="loading">loading...</div>
    <div id="calendar"></div>
</body>


