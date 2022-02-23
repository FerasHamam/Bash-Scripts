        {       
                if(NR == 1){
                SUM=$5;MIN=$5;MAX=$5;min_name=$9;max_name=$9;
                }
                SUM+=$5
                if(min>$5){
                        min=$5
                        min_name=$9
                }
                if (max<$5){
                        max=$5  
                        max_name=$9     
                }
        }
        END{
        print "Size of files:",SUM/1024/1024,"MB"
        if(stats == 1)
                {
                        print "Max file NAME:",max_name,"  Size:",MAX/1024/1024"MB"
                        print "Min File Name:",min_name,"  Size:",MIN/1024/1024,"MB"
                } 
        }
