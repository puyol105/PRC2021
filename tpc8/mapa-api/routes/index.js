var express = require('express');
var router = express.Router();
var gdb = require('../utils/graphdb');
var axios = require('axios')

/* GET Cidades */
router.get('/cidades', async function(req, res) {
  var myquery = `select ?s ?n ?d where {
    ?s a :Cidade;
         :nome ?n;
         :distrito ?d .
  }
  order by ?n`
  var result = await gdb.execQuery(myquery)
  var dados = result.results.bindings.map(c => {
    return {
      id: c.s.value.split("#")[1],
      nome: c.n.value,
      distrito: c.d.value
    }
  })
  res.jsonp(dados);
});

/* GET Cidades/:id */
router.get('/cidades/:id', async function(req, res, next) {
  var myquery = `select ?s ?n ?d ?p ? desc where {
    :${req.params.id} a :Cidade;
         :nome ?n;
         :distrito ?d;
         :populacao ?p;
         :descrição ?desc .
  }
  `
  var result = await gdb.execQuery(myquery)
  var myquery2 = `select ?s ?n ?d ?p ? desc where {
    ?s a :Ligação;
         :origem :${req.params.id};
         :destino ?c;
         :distância ?dist.
    ?c :nome ?n.
  }
  order by ?n
  `
  var ligacoes = await gdb.execQuery(myquery2)
  var ligLimpa = ligacoes.results.bindings.map(l => {
    return {
      id: l.c.value.split("#")[1],
      nome: l.n.value,
      disância: l.dist.value
    }
  })
  var dados = {
    id: req.params.id,
    nome: result.results.bindings[0].n.value,
    distrito: result.results.bindings[0].d.value,
    populacao: result.results.bindings[0].p.value,
    descricao: result.results.bindings[0].desc.value,
    ligações: []
  }
  res.jsonp(dados);
});

/* POST Cidades */
router.post('/cidades', function(req, res, next) {
  var myquery = `insert data {
    :${req.body.id} rdf:type owl:NamedIndividual , :Cidade ;
     :nome "${req.body.nome}" ;
     :distrito "${req.body.distrito}" ;
     :populacao "${req.body.populacao}" ;
     :descricao "${req.body.descricao}" ;
  }
  `
  await gdb.execTransaction(myquery)
  res.jsonp("Triplos inseridos: " + result);
});

/* DEL Cidades/:id */
router.delete('/cidades/:id', function(req, res, next) {
  var cidade = await axios.get("http://localhost:13000/cidades/" + req.params.id)
  var myquery = `delete data {
    :${cidade.data.id}
     :nome "${cidade.data.nome}" ;
     :distrito "${cidade.data.distrito}" ;
     :populacao "${cidade.data.populacao}" ;
     :descricao "${cidade.data.descricao}" ;
  }
  `
  var result = await gdb.execTransaction(myquery)
  res.jsonp("Dados");
});

module.exports = router;
