enum UrlWebservice {
  urlLocal("192.168.0.107:8080"),
  endPointProdutos("/produtos");

  final String url;

  const UrlWebservice(this.url);
}
