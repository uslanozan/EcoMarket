library;

String global_language = 'English'; // Default olarak English

//todo: sayfaların hangi highlightları kullanacağına karar vermek için List<List<String>> tutmak gerek
// Highlight Words
// EcoBot Info
List<String> global_trHighlightWords = ['EcoBot', 'e-ticaret', 'Google', 'Gemini', 'Ozan Uslan'];
List<String> global_enHighlightWords = ['EcoBot', 'e-commerce', 'Google', 'Gemini AI', 'Ozan Uslan'];

// New Ideas Questions
List<String> global_enHighlightWordsQuestion = ['category', 'categories', 'material', 'materials', 'country', 'countries', 'budget', 'eco-friendly'];
List<String> global_trHighlightWordsQuestion = ['kategorisi', 'kategorileri', 'materyali', 'materyalleri', 'ülke', 'ülkeleri', 'bütçesi', 'çevre dostu'];

// Answers
// New Ideas Answers
Map<String, String> global_newIdeasAnswers = {};
// Market Research Answers
Map<String, String> global_marketResearchAnaswers = {};
// Eco Improve Answers
Map<String, String> global_ecoImproveAnswers = {};
