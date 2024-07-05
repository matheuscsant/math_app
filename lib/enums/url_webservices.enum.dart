enum UrlWebservice {
  urlLocal("192.168.0.108:8080"),
  endPointProdutos("/produtos"),
  endPointPostAllProdutos("/produtos/create-all");

  final String url;

  const UrlWebservice(this.url);
}
