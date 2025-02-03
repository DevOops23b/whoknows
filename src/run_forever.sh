#!/bin/bash

#Brugt kommando: $ shellcheck run_forever.sh
#Forestiller mig at dette er et godt debugging tool, også til at opdatere kode.
#Denne kommando kom med en masse rettelser til dette script. 

#GAMMEL KODE:

# (: <<'COMMENT') IKKE en del af koden, udekommenterer bare store kodestykke
: <<'COMMENT' 

TMP="This variable might become useful at some point. Otherwise delete it." 

while true
do
    python2 "$PYTHON_SCRIPT_PATH"
    if [ $? -ne 0 ]; then
        echo "Script crashed with exit code $?. Restarting..." >&2
        sleep 1
    fi
done

COMMENT
# (COMMENT) IKKE en del af koden, slutter bare udekommenteringen af kodestykket.


#FEJL = fejl/rettelser shellcheck bla. kommer med:

#1 - så siger den når variabler ikke bliver brugt. (TMP)
#2 - Den fortæller om manglende anførselsteg.
#3 - Den opdaterer gammel kode, til en mere læsbar kode. ('$?' til 'if' i stedet)
#4 - Forkerte referencer. ('$?' referer til en condition i stedet for en command)



#NY RETTET KODE
PYTHON_SCRIPT_PATH=$1

# 'Nu blev den useful'
#Vi gemmer værdien i en variable, før vi bruger den i echo, som ShellCheck anbefaler.
TMP=$?

while true
do
    
    if ! python2 "$PYTHON_SCRIPT_PATH"; then
        echo "Script crashed with exit code $TMP. Restarting..." 
        sleep 1
    fi
done

# Nu kører koden smooth.