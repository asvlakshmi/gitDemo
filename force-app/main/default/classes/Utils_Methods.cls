/*
    Author          : Accenture 
    Date Created    : 11/10/2010
    Description     : Utility class for commonly used methods 
*/
public without sharing class Utils_Methods 
{
    // escaping SOSL special characters & | ! ( ) { } [ ] ^ “ ~ * ? : \ ' for the FIND expression
    public static String escapeForSOSL(String str) {
        //Pattern patt = Pattern.compile('([\\\'\\?\\&\\|\\!\\{\\}\\[\\]\\(\\)\\^\\~\\*\\:\\"\\+\\-\\\\])');
        Pattern patt = Pattern.compile('([\\\'\\|\\!\\{\\}\\[\\]\\(\\)\\^\\~\\*\\:\\"\\+\\-\\\\])');
        return patt.matcher(str).replaceAll('\\\\$1');  
    }

    // escaping special characters \ ' for the WHERE condition
    public static String escapeForWhere(String str) {
        return STRING.escapeSingleQuotes(str.replace('\\', '\\\\'));
    }
    
    //Formats the date according to the user's locale and returns the corresponding string
     public static string convertToString(Map<String, Schema.SObjectField> mapField, Map<String,Schema.DisplayType> mapType, SObject obj, String fieldAPIName)
    {
        System.debug('#### convertToString');
        String dateAsString;
        Schema.DisplayType fieldType = mapType.get(fieldAPIName);
        Map<String, String> mappedValues = new Map<String, String>(); //map for holding locale to datetime format
        mappedValues = mapLocaleValues(); //populate the map with all the locale specific datetime formats
        String user_locale = UserInfo.getLocale(); //grab the locale of the user
        system.debug('userlocale'+user_locale);
        String datetime_format = 'dd/MM/yyyy'; //variable for the datetime format defaulted to the France format
        
        System.debug('#### FieldType.name(): '+FieldType.name());
 
        if(FieldType.name() == 'DATE' || fieldType.name() == 'DATETIME')
        {
            System.debug('#### FieldType is Date or DateTime');
            DateTime objDate = (DateTime)obj.get(mapField.get(fieldAPIName));
            if (mappedValues.containsKey(user_locale)) 
            { //if the map contains the correct datetime format                    
                datetime_format = mappedValues.get(user_locale); //grab the datetime format for the locale
                System.debug('#### datetime_format: '+datetime_format);
            }
            if(objDate != null && datetime_format!=null)
                dateAsString = objDate.format(datetime_format);
            return dateAsString;
        }        
        else if(fieldType.name() == 'anytype')
        {
            System.debug('#### FieldType is anytype');
            String valueAsString;
            if(obj.get(mapField.get(fieldAPIName)) != null)
               valueAsString = String.valueof(obj.get(mapField.get(fieldAPIName)));
            return valueAsString;
        }
        else
        {
            System.debug('#### FieldType is else');
            String value = String.valueof(obj.get(mapField.get(fieldAPIName)));
            return value;
        }
    }
 
    //Map of User locale and Date Format
    public static Map<String, String> mapLocaleValues() 
    {
            Map<String, String> locale_map = new Map<String, String>(); //holds the locale to timedate formats
            locale_map.put('ar', 'dd/MM/yyyy');
            locale_map.put('ar_AE', 'dd/MM/yyyy');
            locale_map.put('ar_BH', 'dd/MM/yyyy');
            locale_map.put('ar_JO', 'dd/MM/yyyy');
            locale_map.put('ar_KW', 'dd/MM/yyyy');
            locale_map.put('ar_LB', 'dd/MM/yyyy');
            locale_map.put('ar_SA', 'dd/MM/yyyy');
            locale_map.put('bg_BG', 'yyyy-M-d');
            locale_map.put('ca', 'dd/MM/yyyy');
            locale_map.put('ca_ES', 'dd/MM/yyyy');
            locale_map.put('ca_ES_EURO', 'dd/MM/yyyy');
            locale_map.put('cs', 'd.M.yyyy');
            locale_map.put('cs_CZ', 'd.M.yyyy');
            locale_map.put('da', 'dd-MM-yyyy');
            locale_map.put('da_DK', 'dd-MM-yyyy');
            locale_map.put('de', 'dd.MM.yyyy');
            locale_map.put('de_AT', 'dd.MM.yyyy');

            locale_map.put('de_AT_EURO', 'dd.MM.yyyy');
            locale_map.put('de_CH', 'dd.MM.yyyy');
            locale_map.put('de_DE', 'dd.MM.yyyy');
            locale_map.put('de_DE_EURO', 'dd.MM.yyyy');
            locale_map.put('de_LU', 'dd.MM.yyyy');
            locale_map.put('de_LU_EURO', 'dd.MM.yyyy');
            locale_map.put('el_GR', 'd/M/yyyy');
            locale_map.put('en_AU', 'd/MM/yyyy');
            locale_map.put('en_B', 'M/d/yyyy');
            locale_map.put('en_BM', 'M/d/yyyy');
            locale_map.put('en_CA', 'dd/MM/yyyy');
            locale_map.put('en_GB', 'dd/MM/yyyy');
            locale_map.put('en_GH', 'M/d/yyyy');
            locale_map.put('en_ID', 'M/d/yyyy');
            locale_map.put('en_IE', 'dd/MM/yyyy');
            locale_map.put('en_IE_EURO', 'dd/MM/yyyy');
            locale_map.put('en_NZ', 'd/MM/yyyy');
            locale_map.put('en_SG', 'M/d/yyyy');
            locale_map.put('en_US', 'M/d/yyyy hh:mm:ss Z');
            locale_map.put('en_ZA', 'yyyy/MM/dd');
            locale_map.put('es', 'd/MM/yyyy');
            locale_map.put('es_AR', 'dd/MM/yyyy');
            locale_map.put('es_BO', 'dd-MM-yyyy');
            locale_map.put('es_CL', 'dd-MM-yyyy');
            locale_map.put('es_CO', 'd/MM/yyyy');
            locale_map.put('es_CR', 'dd/MM/yyyy');
            locale_map.put('es_EC', 'dd/MM/yyyy');
            locale_map.put('es_ES', 'd/MM/yyyy');
            locale_map.put('es_ES_EURO', 'd/MM/yyyy');
            locale_map.put('es_GT', 'd/MM/yyyy');
            locale_map.put('es_HN', 'MM-dd-yyyy');
            locale_map.put('es_MX', 'd/MM/yyyy');
            locale_map.put('es_PE', 'dd/MM/yyyy');
            locale_map.put('es_PR', 'MM-dd-yyyy');
            locale_map.put('es_PY', 'dd/MM/yyyy');
            locale_map.put('es_SV', 'MM-dd-yyyy');
            locale_map.put('es_UY', 'dd/MM/yyyy');
            locale_map.put('es_VE', 'dd/MM/yyyy');
            locale_map.put('et_EE', 'd.MM.yyyy');
            locale_map.put('fi', 'd.M.yyyy');
            locale_map.put('fi_FI', 'd.M.yyyy');
            locale_map.put('fi_FI_EURO', 'd.M.yyyy');
            locale_map.put('fr', 'dd/MM/yyyy hh:mm:ss Z');
            locale_map.put('fr_BE', 'd/MM/yyyy');
            locale_map.put('fr_CA', 'yyyy-MM-dd');
            locale_map.put('fr_CH', 'dd.MM.yyyy');
            locale_map.put('fr_FR', 'dd/MM/yyyy hh:mm:ss Z');
            locale_map.put('fr_FR_EURO', 'dd/MM/yyyy');
            locale_map.put('fr_LU', 'dd/MM/yyyy');
            locale_map.put('fr_MC', 'dd/MM/yyyy');
            locale_map.put('hr_HR', 'yyyy.MM.dd');
            locale_map.put('hu', 'yyyy.MM.dd');
            locale_map.put('hy_AM', 'M/d/yyyy');
            locale_map.put('is_IS', 'd.M.yyyy');
            locale_map.put('it', 'dd/MM/yyyy');
            locale_map.put('it_CH', 'dd.MM.yyyy');
            locale_map.put('it_IT', 'dd/MM/yyyy');
            locale_map.put('iw', ' dd/MM/yyyy');
            locale_map.put('iw_IL', ' dd/MM/yyyy');
            locale_map.put('ja', 'yyyy/MM/dd');
            locale_map.put('ja_JP', 'yyyy/MM/dd');
            locale_map.put('kk_KZ', 'M/d/yyyy');
            locale_map.put('km_KH', 'M/d/yyyy');
            locale_map.put('ko', 'yyyy. M. d');
            locale_map.put('ko_KR', 'yyyy. M. d');
            locale_map.put('lt_LT', 'yyyy.M.d');
            locale_map.put('lv_LV', 'yyyy.d.M');
            locale_map.put('ms_MY', 'dd/MM/yyyy');
            locale_map.put('nl', 'd-M-yyyy');
            locale_map.put('nl_BE', 'd/MM/yyyy');
            locale_map.put('nl_NL', 'd-M-yyyy');
            locale_map.put('nl_SR', 'd-M-yyyy');
            locale_map.put('no', 'dd.MM.yyyy');
            locale_map.put('no_NO', 'dd.MM.yyyy');
            locale_map.put('pl', 'yyyy-MM-dd');
            locale_map.put('pt', 'dd-MM-yyyy');
            locale_map.put('pt_AO', 'dd-MM-yyyy');
            locale_map.put('pt_BR', 'dd/MM/yyyy');
            locale_map.put('pt_PT', 'dd-MM-yyyy');
            locale_map.put('ro_RO', 'dd.MM.yyyy');
            locale_map.put('ru', 'dd.MM.yyyy');
            locale_map.put('sk_SK', 'd.M.yyyy');
            locale_map.put('sl_SI', 'd.M.y');
            locale_map.put('sv', 'yyyy-MM-dd');
            locale_map.put('sv_SE', 'yyyy-MM-dd');
            locale_map.put('th', 'M/d/yyyy');
            locale_map.put('th_TH', 'd/M/yyyy');
            locale_map.put('tr', 'dd.MM.yyyy hh:mm:ss Z');
            locale_map.put('ur_PK', 'M/d/yyyy');
            locale_map.put('vi_VN', ' dd/MM/yyyy');
            locale_map.put('zh', 'yyyy-M-d');
            locale_map.put('zh_CN', 'yyyy-M-d');
            locale_map.put('zh_HK', 'yyyy-M-d');
            locale_map.put('zh_TW', 'yyyy/M/d');
            return locale_map; //return the map
    }        
}