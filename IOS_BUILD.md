# Збірка та встановлення iOS-версії «Скиба» — безкоштовно (без Apple Developer Program)

Цей маршрут дозволяє отримати робочий додаток на iPhone **без оплати $99/рік** і
**без власного Mac**. Збірка відбувається в хмарі (Codemagic), встановлення — з Windows
через Sideloadly з вашим звичайним (безкоштовним) Apple ID.

## ⚠️ Обмеження безкоштовного способу

- ⏳ **Додаток працює 7 днів**, потім перестає запускатися — треба переустановити/оновити
  (AltStore вміє оновлювати автоматично по WiFi).
- 📱 Не більше **3 sideload-додатків** одночасно на один Apple ID.
- 🔔 **Без push-нотифікацій** (free-підпис їх не дозволяє).
- ⚙️ Після встановлення треба **довірити розробника** в налаштуваннях iPhone.

---

## Крок 1. Залити код на GitHub

Репозиторій ще не ініціалізований. З кореня проекту (`G:\dev\SkybaBonus`):

```powershell
git init
git add .
git commit -m "Add iOS platform + Codemagic unsigned build"
git branch -M main
git remote add origin https://github.com/<ВАШ_АКАУНТ>/skyba-bonus.git
git push -u origin main
```

(Спершу створіть порожній приватний репозиторій `skyba-bonus` на GitHub.)

## Крок 2. Підключити Codemagic

1. Зайдіть на https://codemagic.io → **Sign up with GitHub** (безкоштовний тариф, 500 хв/міс).
2. **Add application** → виберіть свій репозиторій `skyba-bonus`.
3. Codemagic сам знайде `codemagic.yaml` у корені.
4. Натисніть **Start new build** → workflow **iOS unsigned (sideload)**.
   (Або просто зробіть `git push` у `main` — білд стартує автоматично.)
5. Збірка триває ~10–15 хв. Коли завершиться — у розділі **Artifacts** буде
   файл **`SkybaBonus-unsigned.ipa`**. Завантажте його на свій Windows-ПК.

> Якщо на безкоштовному тарифі недоступний `mac_mini_m2`, поміняйте в `codemagic.yaml`
> рядок `instance_type:` на `mac_mini_m1`.

## Крок 3. Встановити .ipa на iPhone через Sideloadly (на Windows)

1. Завантажте **Sideloadly**: https://sideloadly.io (Windows-версія, безкоштовно).
   Він автоматично встановить потрібний драйвер/iTunes-компоненти для зв'язку з iPhone.
2. Підключіть iPhone до ПК кабелем, розблокуйте, натисніть **Trust / Довіряти** на телефоні.
3. У Sideloadly:
   - перетягніть `SkybaBonus-unsigned.ipa` у вікно;
   - у полі **Apple ID** введіть свій звичайний Apple ID (безкоштовний підійде);
   - натисніть **Start**. Введіть пароль Apple ID (якщо ввімкнена 2FA — створіть
     app-specific password на https://appleid.apple.com).
4. Sideloadly підпише й встановить додаток. На iPhone:
   **Settings → General → VPN & Device Management → [ваш Apple ID] → Trust**.
5. Запускайте «Скиба» з домашнього екрана.

### Оновлення раз на 7 днів
Коли через тиждень додаток перестане відкриватися — повторіть Крок 3 (Sideloadly,
той самий .ipa, **Start**). Альтернатива з автооновленням по WiFi — **AltStore**
(https://altstore.io) з AltServer на ПК.

---

## Що вже налаштовано в проекті

- Тека `ios/` згенерована (Flutter 3.27).
- Bundle ID: `ua.skyba.bonus` (як на Android).
- Назва на екрані: **Скиба**; локалі uk + en; портретна орієнтація.
- Іконки додатку (21 розмір, без альфа-каналу).
- `codemagic.yaml` — workflow `ios-unsigned` для несигнованої збірки.

## Що НЕ налаштовано (свідомо, поки не потрібно)

- **Підпис для App Store / TestFlight** — потребує Apple Developer Program ($99/рік).
- **Push-нотифікації (FCM)** — не реалізовані ні на iOS, ні на Android (залежності
  `firebase_*` лише оголошені). Потребують Firebase-проекту, APNs-ключа й коду.
