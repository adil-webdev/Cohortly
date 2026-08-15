<div align="center">

# 🎓 Cohortly

**A modern Learning Management System built with Ruby on Rails 8**

Create courses, organize them into sections and lessons, upload video content,
and track every student's progress — all in one place.

[![Ruby](https://img.shields.io/badge/Ruby-3.3.5-CC342D?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0-D30001?logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4-06B6D4?logo=tailwindcss&logoColor=white)](https://tailwindcss.com/)
[![Hotwire](https://img.shields.io/badge/Hotwire-Turbo_+_Stimulus-yellow)](https://hotwired.dev/)

</div>

---

## ✨ Features

- **👥 Role-based access** — Students, Instructors, and Admins, each with their own dashboard (powered by Devise)
- **📚 Course management** — Instructors create and edit courses with nested sections and lessons via dynamic forms
- **🎬 Video lessons** — Upload lesson videos with Active Storage and stream them in a built-in course player
- **📈 Progress tracking** — Per-lesson status (`not_started` → `in_progress` → `completed`) with automatic course completion percentages
- **📝 Enrollments** — Students enroll in courses and follow their learning journey from their dashboard
- **⚡ SPA-like UX** — Hotwire (Turbo + Stimulus) for fast, reactive pages without heavy JavaScript
- **🎨 Beautiful UI** — Tailwind CSS 4 + daisyUI components
- **📧 Dev mail preview** — Letter Opener catches emails in development

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Ruby on Rails 8.0 |
| Language | Ruby 3.3.5 |
| Database | MySQL (mysql2) |
| Frontend | Hotwire (Turbo + Stimulus), Tailwind CSS 4, daisyUI |
| JS bundling | esbuild (via jsbundling-rails) |
| Authentication | Devise |
| File uploads | Active Storage |
| Background jobs | Solid Queue |
| Caching | Solid Cache |
| WebSockets | Solid Cable |
| Server | Puma + Thruster |
| Deployment | Kamal (Docker) |
| Testing | Minitest, Capybara, Selenium |
| Code quality | RuboCop (Omakase), Brakeman |

## 🧱 Domain Model

```
User (student / instructor / admin)
 ├── instructor ──< Course >──< Section >──< Lesson (has video)
 └── student ──< Enrollment >──< Course
                    └──< LessonProgress >── Lesson
```

- A **Course** belongs to an instructor and contains **Sections**, which contain **Lessons**
- A **Student** enrolls in courses through **Enrollments** (`active` / `completed` / `dropped`)
- **LessonProgress** records each enrolled student's status per lesson and feeds `Course#progress_for_user`

## 🚀 Getting Started

### Prerequisites

- Ruby **3.3.5**
- Node.js **20.11.1** + Yarn
- MySQL **5.6.4+** (8.x recommended)

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/Cohortly.git
cd Cohortly

# 2. Install dependencies & prepare the database
bin/setup

# 3. Configure your database credentials
#    Create a .env file (dotenv-rails is included):
echo "DATABASE_USER=your_mysql_user" >> .env
echo "DATABASE_PASS=your_mysql_password" >> .env

# 4. Create and migrate the database (if not done by bin/setup)
bin/rails db:create db:migrate
```

### Running the app

```bash
bin/dev
```

This starts the Rails server, the Tailwind CSS watcher, and the esbuild
watcher via `Procfile.dev`. Then open **http://localhost:3000**.

> 💡 Prefer separate terminals? Run `bin/rails server`,
> `bin/rails tailwindcss:watch`, and `yarn build --watch` yourself.

## 🧪 Testing & Quality

```bash
# Run the test suite (models, controllers, integration)
bin/rails test

# Run system tests (Capybara + Selenium)
bin/rails test:system

# Lint Ruby code
bin/rubocop

# Security scan
bin/brakeman
```

## 🚢 Deployment

Cohortly ships with **Kamal** for Docker-based deployment:

```bash
# Edit config/deploy.yml with your server details, then:
bin/kamal setup
bin/kamal deploy
```

A production-ready `Dockerfile` is included at the project root.

## 📁 Project Structure

```
app/
├── controllers/     # Courses, Sections, Lessons, Enrollments, Dashboards, ...
├── models/          # User, Course, Section, Lesson, Enrollment, LessonProgress
├── views/           # ERB templates (student & instructor dashboards, course player)
├── javascript/      # Stimulus controllers (esbuild bundle)
└── assets/          # Tailwind CSS + compiled builds (Propshaft)
config/              # Routes, database, Kamal deploy config
db/                  # Migrations & schema (plus Solid Queue/Cache/Cable schemas)
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m "Add my feature"`
4. Push and open a Pull Request

Please make sure `bin/rails test`, `bin/rubocop`, and `bin/brakeman` all pass before submitting.

## 📄 License

This project is open source. Add a `LICENSE` file to specify terms.
