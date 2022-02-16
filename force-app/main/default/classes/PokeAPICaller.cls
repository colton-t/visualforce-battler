public with sharing class PokeAPICaller {
    public PokeAPICaller() {
        function fetchKantoPokemon() {
            fetch('https://pokeapi.com/api/v2/pokemon?limit=151')

            .then(response => response.json())

            .then(allpokemon => console.log(allpokemon))
        }
    }
}
