/// Dados de um certificado e seu endereço de verificação.
///
/// Parâmetros:
/// - `title`: nome do certificado.
/// - `issuer`: instituição que emitiu o certificado.
/// - `date`: data ou período de emissão.
/// - `verificationUrl`: endereço para validar o certificado.
class Certificate {
  final String title;
  final String issuer;
  final String date;
  final String verificationUrl;

  const Certificate({
    required this.title,
    required this.issuer,
    required this.date,
    required this.verificationUrl,
  });
}
