# 🔗 Shorten My Link

> Um aplicativo Flutter para encurtar e gerenciar seus links de forma simples e eficiente

## 📱 Sobre o Projeto

**Shorten My Link** é um aplicativo mobile desenvolvido em Flutter que permite aos usuários encurtar URLs longas e gerenciar seus links encurtados de forma prática. O app se comunica com uma API REST para processar os links e armazena o histórico localmente, permitindo acesso rápido aos links já encurtados mesmo sem conexão com a internet.

## 🏗️ Arquitetura

O projeto segue a arquitetura **MVVM (Model-View-ViewModel)** utilizando **BLoC/Cubit** para gerenciamento de estado, garantindo separação clara de responsabilidades e código testável.

### Estrutura MVVM

```
┌─────────────────────────────────────────────────────────────┐
│                         VIEW                                │
│  📱 Widgets e UI Components                                 │
│  • HomePage - Tela principal                                │
│  • AboutPage - Sobre o desenvolvedor                        │
└──────────────────────┬──────────────────────────────────────┘
                       │ BlocProvider / BlocConsumer
                       ↓
┌─────────────────────────────────────────────────────────────┐
│                      VIEWMODEL                              │
│  🎯 Gerenciamento de Estado com Cubit                       │
│  • HomeCubit - Lógica de negócio da home                    │
│  • HomeState - Estados da aplicação                         │
│    - HomeState                                              │
│    - HomeLoadingState                                       │
│    - HomeErrorState                                         │
└──────────────────────┬──────────────────────────────────────┘
                       │ Chama métodos e recebe dados
                       ↓
┌─────────────────────────────────────────────────────────────┐
│                       MODEL                                 │
│  💾 Dados e Lógica de Negócio                               │
│  • ApiService - Comunicação com API REST                    │
│  • StorageRepository - Persistência com Hive                │
│  • AliasModel - Modelo de dados de link                     │
│  • LinksModel - Modelo de URLs                              │
└─────────────────────────────────────────────────────────────┘
```

### 🎯 BLoC/Cubit Pattern

O projeto utiliza o **Cubit** (uma versão simplificada do BLoC) para gerenciamento de estado:

**Fluxo de Dados:**
```
User Action → View → Cubit → Service/Repository → API/Storage
                ↑                                      ↓
                └──────── Emit New State ──────────────┘
```

### 💾 Armazenamento de Dados com Hive

O app utiliza **Hive**, um banco de dados NoSQL leve e rápido para Flutter:

**Características do Hive:**
- 🚀 **Performance**: Até 30x mais rápido que SQLite
- 📦 **Leve**: Apenas ~1.5MB adicionado ao app
- 💪 **Type-Safe**: Suporte a tipos Dart nativos
- 🔄 **Síncrono e Assíncrono**: Operações flexíveis
- 📱 **Cross-Platform**: Funciona em todas as plataformas Flutter

## 🧪 Testes Unitários

### 🛠️ Ferramentas de Teste

- **flutter_test**: Framework de testes do Flutter
- **mockito**: Criação de mocks para testes unitários
- **build_runner**: Geração automática de código de mocks
- **bloc_test**: Testes específicos para BLoCs e Cubits

## 🚀 Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.35.4 ou superior)
- [FVM](https://fvm.app/) (opcional, mas recomendado)
- Android Studio / Xcode (para emuladores)
- Editor: VS Code ou Android Studio

### 📦 Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/camposmichel/shorten-my-link.git
cd shorten_my_link
```

2. **Instale as dependências**
```bash
# Com FVM
fvm flutter pub get

# Sem FVM
flutter pub get
```

3. **Gere os arquivos necessários (se necessário)**
```bash
# Com FVM
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Sem FVM
flutter pub run build_runner build --delete-conflicting-outputs
```

### ▶️ Executar o App

```bash
# Com FVM
fvm flutter run

# Sem FVM
flutter run
```

### 🧪 Executar Testes

```bash
# Todos os testes
fvm flutter test

# Testes específicos
fvm flutter test test/models/
fvm flutter test test/widgets/

# Com cobertura
fvm flutter test --coverage

# Teste específico
fvm flutter test test/models/link_model_test.dart
```

## 🌐 API

O app consome a API de encurtamento de links:

**Base URL:** `https://url-shortener-server.onrender.com/api/alias`

**Endpoints:**
- `POST /api/alias` - Encurtar link
- `GET /api/alias/:alias` - Obter link original

## 👨‍💻 Desenvolvedor

**Michel Campos**

- 💼 Frontend e Mobile Developer
- 🛠️ Flutter | Dart | JavaScript | Angular | NGRX | NodeJS
- 📧 Email: michelcsilva@live.com
- 💼 LinkedIn: [/michelcsilva](https://linkedin.com/in/michelcsilva)
- 🐙 GitHub: [/camposmichel](https://github.com/camposmichel)
- 💬 Discord: camposmichel

**Made with ❤️ and Flutter**
