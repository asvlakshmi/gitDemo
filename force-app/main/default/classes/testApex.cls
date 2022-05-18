public class testApex {
     public String solution(String name, String surname, integer age) {
        
        // write your code in Java SE 8
        String subStrName = name.substring(0,1);
        String subStrSurname = surname.substring(0,1);
        
        String newString = subStrName + subStrSurname;
        system.debug(newString);
         return newString;
    }


}