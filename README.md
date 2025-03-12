# Memo Deck
Memo Deck to aplikacja do efektywnej nauki fiszek z powtórzeniami. Wykorzystuje SuperMemo do oceny stopnia opanowania karty przez użytkownika i planowania kolejnych powtórek. Dzięki synchronizacji aplikacji z firebase umożliwia pracę na wielu urządzeniach o dostęp do własnych kart dla każdego użytkownika.

## Demo
<div style="display: flex; align-items: center;">
  <img src="Images/Home.gif" alt="Opis obrazu" height="500" style="margin-right: 10px;">
  <img src="Images/quiz.gif" alt="Opis obrazu" height="500" style="margin-right: 10px;">
  <img src="Images/HomePage_screenshot.jpg" alt="Opis obrazu" height="500" style="margin-right: 10px;">
  <img src="Images/Screenshot_20250312_162540.jpg" alt="Opis obrazu" height="500" style="margin-right: 10px;">
</div>

## 🛠 Technologie 
## 🛠 Technologie

W tym projekcie wykorzystano następujące technologie:

- **Firebase** – użyte do autoryzacji użytkowników oraz przechowywania danych (storage). Firebase umożliwia synchronizację danych między różnymi urządzeniami oraz przechowywanie kart użytkownika w chmurze.
  - [Firebase](https://firebase.google.com/)

- **flutter_bloc** – biblioteka do zarządzania stanem aplikacji z użyciem wzorca BLoC (Business Logic Component). Pozwala na lepszą organizację kodu, szczególnie w większych aplikacjach, i oddziela logikę aplikacji od interfejsu użytkownika.
  - [Bloc](https://pub.dev/packages/flutter_bloc)
- **Algorytm SuperMemo** – implementacja algorytmu służącego do oceny opanowania kart oraz wyznaczania optymalnych interwałów powtórek. Algorytm ten jest używany do efektywnego nauczania i zapamiętywania informacji w systemie opartym na powtórkach z czasem.
  - [SuperMemo](https://en.wikipedia.org/wiki/SuperMemo)


## 🎯 Funkcjonalności
- Tworzenie i zarządzanie taliami fiszek.
- Przeglądanie kart oraz śledzenie statystyk nauki.
- Tryb nauki oparty na algorytmie SuperMemo.
- Synchronizacja postępów między urządzeniami dzięki Firebase.
- Przeglądanie kolekcji fiszek wraz z filtrowaniem, dzięki metodzie paginacji jest realizowane w efektywny sposób.
