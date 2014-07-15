BEGIN       { substitutes["Automatic digest processor"] = "WotC's listserv" }
NR == 1     { 
              print $2
              elm_line = $0
              if ($3 == "From")
                {
                  extra_blanks = 1;
                  crap_length = length( $1 $2 ) + 8
                }
              else
                crap_length = length( $1 $2 ) + 2
            }
NF == 0     {
              ++instance
              if (instance == 2 + extra_blanks)
                {
                  print NR + 1
                  name = substr( elm_line, crap_length + 1, \
                                 80 - crap_length - elm_date_length );
                  ds_pos = index( name, "  " )
                  if (ds_pos > 0)
                    name = substr( name, 1, ds_pos - 1 )

                  if (substitutes[name] != "")
                    name = substitutes[name]

                  subject_field_length = 52 - 2 * length( LINES ) - \
                                         length( name )
                  if (subject == "")
                    subject = "<no subject>"
                  subject = subject "                                                 "
                  printf "line ^^^lt/^^^L | %s | %s | %s\n", date, name,\
                         substr( subject, 1, subject_field_length ) \
                      > "/tmp/me2." PID
                  exit
                }
            }
/^Date:/    {
              elm_date_length = length( $0 ) - 7
              if (NF == 4)
                date = $2
              else
                if (NF == 6)
                  date = $3 " " $2 " " $6 
                else
                  {
                    date = $3 " " $4 " " $5
                    if ($3 < 10)
                      elm_date_length = length( $0 ) - 10
                    else
                      elm_date_length = length( $0 ) - 9
                  }
            }
/^Subject:/ {
              subject = substr( $0, 10 )
            }
