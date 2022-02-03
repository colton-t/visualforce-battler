public class PokemonRetrieveAPI {
    public static HttpResponse getCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon?limit=151&offset=0');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        
        if(response.getStatusCode() == 200) {
            // system.debug(response.getBody());
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // system.debug(results);
            
            List<Pokemon__c> pokemonList = new List<Pokemon__c>();
            
            Object actualList = results.get('results');
            system.debug(actualList);
            
            
            for (String key: results.keySet()) {
                system.debug(results.get(key));
            }
            
        }
        return response;
    }
}