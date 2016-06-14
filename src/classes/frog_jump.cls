public with sharing class frog_jump {
  // public void PrintFrogPath(Integer[] a, integer length, integer aCount,  Integer[] path, integer bCount) {
  
        /*if(aCount == length && path[bCount-1] == a[aCount-1]) {
            system.debug('path : '+path);
            return;
        } else if(aCount < length) {
            for(Integer i = 1; i<=2 ; i++) {
                path[bCount] = a[aCount];
                PrintFrogPath(a, length, aCount+i, path, bCount+1);
            }
            
        }*/
        @future
   public static void PrintFrogPath(integer length) {
        Integer[] finalpath  = new Integer[length];
        finalpath.add(0,1);
         if(math.mod(length, 2) == 0) {
            length = length-1;
         }
         Integer count = 1;
         for(Integer i = 1; i<=length ; i+2) {
             finalpath.add(count, 2);
             count++;
         }
         if(math.mod(length, 2) == 0) {
             finalpath.add(count, 1);
         }
       
        system.debug('final: '+finalpath);
    }
}