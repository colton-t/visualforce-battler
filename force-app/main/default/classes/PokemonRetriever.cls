public class PokemonRetriever {
    
    public static void getPokemon() {
    	Http http = new Http();
        HttpRequest hr = new HttpRequest();
		hr.setEndpoint('https://pokeapi.co/api/v2/pokemon?limit=21&offset=130');
        hr.setMethod('GET');
        HttpResponse response = http.send(hr);
        
        if(response.getStatusCode() == 200) {
            Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> pokemons = (List<Object>) resultMap.get('results');
            
            List<Pokemon__c> pokemonList = new List<Pokemon__c>();
            for(Object pokemon: pokemons) {
                Map<String, Object> newPokemon = (Map<String, Object>) pokemon;
                pokemonList.add(GetPokemonDetails((String) newPokemon.get('url')));
            }
            insert pokemonList;
        }
    }
    
    public static Pokemon__c GetPokemonDetails(String url) {
        Http http = new Http();
        HttpRequest hr = new HttpRequest();
        hr.setEndpoint(url);
        hr.setMethod('GET');
        HttpResponse response = http.send(hr);
        Pokemon__c newPokemon = new Pokemon__c();
        
        if(response.getStatusCode() == 200) {
            String picklistValues = '';
            Map<String, Object> pokemon = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            newPokemon.name = (String) pokemon.get('name');
            newPokemon.Id__c = (Integer) pokemon.get('id');
            Map<String, Object> sprites = (Map<String, Object>) pokemon.get('sprites');
            newPokemon.Image_URL__c = (String) sprites.get('front_shiny');
            
            List<Object> typeList = (List<Object>) pokemon.get('types');
            for(Object type: typeList) {
                Map<String, Object> t = (Map<String, Object>) type;
                Map<String, Object> actualTypes = (Map<String, Object>) t.get('type');
                picklistValues += (String) actualTypes.get('name') + ';';
            }
            
            newPokemon.Type__c = picklistValues.removeEnd(';');
        }
        return newPokemon;
    }
}