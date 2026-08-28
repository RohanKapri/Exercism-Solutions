USING: io io.encodings.utf8 io.files kernel sequences ;
IN: vltava-weather-watch

: read-readings ( path -- readings )
    utf8 file-lines ;

: latest-reading ( path -- reading )
    read-readings last ;

: log-text ( path -- text )
    utf8 file-contents ;

: record-reading ( reading path -- )
    utf8 rot '[ _ print ] with-file-appender ;

: rewrite-log ( readings path -- )
    utf8 set-file-lines  ;