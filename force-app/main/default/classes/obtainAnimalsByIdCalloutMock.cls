@isTest
global class obtainAnimalsByIdCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"animal": {"id":"1", "name":"cat", "eats": "fish", "says": "meow"}}');
        res.setStatusCode(200);
        return res;
    }
}
