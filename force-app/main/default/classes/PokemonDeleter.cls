public class PokemonDeleter {
    public static void killThemAll() {
        List<Pokemon__c> pokemon = [SELECT id FROM Pokemon__c];
        if(pokemon != null) {
            delete pokemon;
        }
    }
}