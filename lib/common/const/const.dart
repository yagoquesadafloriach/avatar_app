// ignore_for_file: lines_longer_than_80_chars

const owner = 'labhousemobile';
const trainDataExample = 'https://replicate.delivery/pbxt/KHUH9jZ3GL0DjQm1xFz5yBkW9DOZDxQdEIBZhLSSsXY4DrOU/data.zip';
const versionExample = 'f461d8ff0c9fb725c1b449b0503845f4a8ae515f46045224e7af1aed57a5da2a';
const versionPhotoMaker = 'ddfc2b08d209f9fa8c1eca692712918bd449f695dabb4a958da31802a9570fe4';

// change baseUrl & apiToken to .env
const baseUrl = 'https://api.replicate.com/v1';
const apiToken = 'r8_MbHFsDGePkPZsR6OhcBmqtfwLS5Zi8f1adJat';
const Map<String, String> headers = {
  'Content-type': 'application/json',
  'Authorization': 'Token $apiToken',
};
