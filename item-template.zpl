^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR8,8~SD30^JUS^LRN^CI0^XZ
^XA
^MMT
^PW406
^LL0203
^LS0
^FT41,93^A0N,113,112^FH\^FD{{ it.id }}^FS
^BY2,3,37^FT135,181^BCN,,Y,N
{% if (String(it.id).length < 6) { %}
^FD>;{{ String("000000" + it.id).slice(-6) }}^FS
{% } else { %}
^FD>;{{ it.id }}^FS
{% } %}
^FT41,134^A0N,19,16^FH\^FD{{ it.title.substring(0, 40) }}^FS
^PQ1,0,1,Y^XZ
