Using meta data to create customized sas tables dosubl                                                                           
                                                                                                                                 
Great question well defined, Thanks.                                                                                             
                                                                                                                                 
github                                                                                                                           
https://tinyurl.com/yy8bw5mm                                                                                                     
https://github.com/rogerjdeangelis/utl-using-meta-data-to-create-customized-sas-tables-do-over                                   
                                                                                                                                 
SAS Forum                                                                                                                        
https://tinyurl.com/yyolb6rb                                                                                                     
https://communities.sas.com/t5/SAS-Programming/Translate-one-dataset-to-another-using-a-custom-metadata-dataset/m-p/584894       
                                                                                                                                 
macros                                                                                                                           
https://tinyurl.com/y9nfugth                                                                                                     
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                       
                                                                                                                                 
*_                   _                                                                                                           
(_)_ __  _ __  _   _| |_                                                                                                         
| | '_ \| '_ \| | | | __|                                                                                                        
| | | | | |_) | |_| | |_                                                                                                         
|_|_| |_| .__/ \__,_|\__|                                                                                                        
        |_|                                                                                                                      
;                                                                                                                                
                                                                                                                                 
data have;                                                                                                                       
 input                                                                                                                           
 (S_NAME S_ID S_DATE S_LOCATION S_REGION S_COMMENTS) ($) S_TEL $24.;                                                             
cards4;                                                                                                                          
Bill 1 21550 UK EMEA None +44 20 999 999                                                                                         
Adam 2 21581 UK EMEA Closing +44 20 999 998                                                                                      
Sean 3 21609 ES EMEA Open +34 01 889 887                                                                                         
Mary 4 21640 US APAC Open +1 555 9901                                                                                            
;;;;                                                                                                                             
run;quit;                                                                                                                        
                                                                                                                                 
data meta;                                                                                                                       
input (VARIABLE ORDER SOURCE) (: $8.);                                                                                           
cards4;                                                                                                                          
Name 1 S_Name                                                                                                                    
ID 2 S_ID                                                                                                                        
Region 3 S_Region                                                                                                                
;;;;                                                                                                                             
run;quit;                                                                                                                        
                                                                                                                                 
WORK.HAVE total obs=4                                                                                                            
                                                                                                                                 
  S_NAME    S_ID    S_DATE    S_LOCATION    S_REGION    S_COMMENTS        S_TEL                                                  
                                                                                                                                 
   Bill      1      21550         UK          EMEA       None         +44 20 999 999                                             
   Adam      2      21581         UK          EMEA       Closing      +44 20 999 998                                             
   Sean      3      21609         ES          EMEA       Open         +34 01 889 887                                             
   Mary      4      21640         US          APAC       Open         +1 555 9901                                                
                                                                                                                                 
                                                                                                                                 
WORK.META total obs=3                                                                                                            
                                                                                                                                 
  VARIABLE    ORDER    SOURCE                                                                                                    
                                                                                                                                 
   Name         1      S_Name                                                                                                    
   ID           2      S_ID                                                                                                      
   Region       3      S_Region                                                                                                  
                                                                                                                                 
                                                                                                                                 
*            _               _                                                                                                   
  ___  _   _| |_ _ __  _   _| |_                                                                                                 
 / _ \| | | | __| '_ \| | | | __|                                                                                                
| (_) | |_| | |_| |_) | |_| | |_                                                                                                 
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                
                |_|                                                                                                              
;                                                                                                                                
                                                                                                                                 
                                                                                                                                 
WORK.WANT total obs=4          | RULES                                                                                           
                               | =====                                                                                           
  S_NAME    S_ID    S_REGION   |                                                                                                 
                               | Only keep the variables in source table defined                                                 
   Bill      1        EMEA     | in the meta data and in the correct order                                                       
   Adam      2        EMEA     |                                                                                                 
   Sean      3        EMEA     |                                                                                                 
   Mary      4        APAC     |                                                                                                 
                                                                                                                                 
*                                                                                                                                
 _ __  _ __ ___   ___ ___  ___ ___                                                                                               
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                              
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                              
| .__/|_|  \___/ \___\___||___/___/                                                                                              
|_|                                                                                                                              
;                                                                                                                                
                                                                                                                                 
%symdel sourcen ordern / nowarn;                                                                                                 
                                                                                                                                 
%array(source,data=meta,var=source);                                                                                             
                                                                                                                                 
data want;                                                                                                                       
                                                                                                                                 
  retain                                                                                                                         
    %do_over(source,phrase=?);                                                                                                   
                                                                                                                                 
  set have;                                                                                                                      
                                                                                                                                 
  keep                                                                                                                           
    %do_over(source,phrase=?);                                                                                                   
                                                                                                                                 
run;quit;                                                                                                                        
                                                                                                                                 
                                                                                                                                 
                                                                                                                                 
                                                                                                                                 
