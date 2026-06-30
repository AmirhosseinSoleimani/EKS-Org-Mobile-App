library;

//TODO below defined coordinates from intent incoming from outside the app
//TODO this is used for temporary storage for lat/long on shared location user tap from outside
//TODO move and store in a new better way
String sharedLat = '';
String sharedLng = '';
String globalRefId = '';
bool isFromBackground = false;
bool redirectIntent = true;
bool urlBuilderIsActive = false;
bool najiRedirect = false;

String currentAppVersion = 'Not Specified';
