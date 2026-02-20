# #!/bin/bash

# a=0

# while [ $a -lt 10 ]
# do
#   echo $a
#   a=`expr $a + 1`
# done

#to read file

while IFS= read -r line #Internal filed separated
do
  echo $line
done < 17-set.sh #< single for reading file