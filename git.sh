#!/bin/bash
#-------- by dnetto ------------------------

######################## VARS ####################################
time=`date '+%d-%m-%Hh%Mm'`; if [ -z "$host" ] ;then host=`uname -n`;fi
w="\033[0m";r="\033[31m";g="\033[32m";y="\033[33m";f="\033[1m"
b="\033[34m";v="\033[35m";c="\033[36m";s="\033[37m";on=1;off=0
pth_l=`dirname $0`
##################################################################

######################## Functions ###############################
function f_echo { if [ $1 -eq $on ] ; then echo $2 ;fi ;}
function f_error { echo "ERROR !! \n  [$r $1 $w] -h pour page de help."; }
function f_start 
{
	while [ 1 ] ; do
		#git pull 
	if [ -f login ] ; then
		mailf=`cat $pth_l/login | grep Mail | cut -d ' ' -f2-`;nomf=`cat $pth_l/login | grep Nom | cut -d ' ' -f2-`
		git config --global user.email $mailf
		git config --global user.name $nomf
		echo ".$nomf.$mailf."
		break 
	else 
		read -p "mail : " MAIL ; read -p "Nom : " NAME ; echo "Mail: $MAIL\nNom: $NAME" > $pth_l/login
	fi
	done
}
function f_help
{
	echo "git sh -help:";echo "\t-h -H\thelp meu";echo "\nusage:"
	echo "\tgitsh [-flag] [\"commit\"]"; echo "\nflags:\n\tsans flags et un commit il \n\tfera: git add . ; git -m commit [\$commentaire]; git push\n"
	echo "\t-a\tgit add [\$argument1]\n\t\t  s'il n'as pas d'args ils fera:[ git add . ] Par defaut"
	echo "\t-c\tgit commit -m\n\t\t  msg defaut : $f\"git sh - $USER - $time - $host\"$w"
	echo "\t-p\tgit push";echo "\t-pull\tgit pull";echo "\t-alias\tset le_nom_passe=sh $PWD/$0$r(beta)$w\n\t\t  ou defaut : gitsh=sh $PWD/$0 $r(beta)$w"
}
####################################################################


######################## code ######################################
f_start
while [ 1 ] ; do
	if [ -s "$1" ] ; then f_error "NO ARGS" ; break ; fi
	if [ "$1" = "-h" ] || [ "$1" = "-H" ] ; then f_help ; break ; fi 
	if [ "$1" = "-a" ] ; then if [ -s "$2" ] ; then git add "." ; else git add "$2" ; fi ; break ; fi
	if [ "$1" = "-c" ] ; then if [ -s "$2" ] ; then f_error "NO COMMIT || DEFAUT= $f\"git sh - $USER - $time - $host\"$w" ; git commit -m "git sh - $USER - $time - $host" ; else git commit -m "$2" ; fi ; break ; fi
	if [ "$1" = "-p" ] ; then git push ; break ; fi
	if [ "$1" = "-pull" ] ; then git pull ; break ; fi
	if [ ${1:0:1} != "-" ] ; then echo "$f-=- git add . -=-$w" ; git add "." ; echo "\n$f-=- commit -m \"$1\" -=-$w\n" ; git commit -m "$1  at [$time]" ; echo "\n$f-=- git push -=-$w\n" ; git push ; break ; fi
	f_error "argument non valide"
	#------- by dnetto -------------------------------------
	break
done
######################################################################
