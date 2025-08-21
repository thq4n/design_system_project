# 📋 PR Creation Rules for TMS Mobile

## 🎯 Overview
This document defines the rules and guidelines for creating Pull Requests (PRs) in the TMS Mobile project. All PRs must follow these standards to ensure consistency, quality, and proper review process.

## 📋 PR Creation Checklist

### ✅ Pre-Creation Checklist
- [ ] **Branch is up to date** with target branch (develop/main)
- [ ] **All commits follow** conventional commit format
- [ ] **Code quality checks** pass (`flutter analyze`, `dart format`)
- [ ] **All tests pass** (`flutter test`)
- [ ] **No sensitive data** in code
- [ ] **Documentation updated** if needed
- [ ] **Breaking changes documented** if any

### ✅ PR Content Requirements

#### 1. **Title Format**
```
type(scope): concise description of changes
```
**Examples:**
- `feat(dashboard): implement dashboard module with user profile`
- `fix(auth): resolve login validation issue`
- `refactor(core): extract common utilities`
- `chore(deps): update flutter dependencies`

#### 2. **Description Structure**
Follow the template in `PULL_REQUEST_TEMPLATE.md` with these sections:

**Required Sections:**
- 📋 **Overview**: Clear description of what the PR accomplishes
- 🎯 **Type of Change**: Check appropriate boxes
- 🔄 **Branch Information**: Source, target, commits count
- 📊 **Changes Summary**: Categorized changes
- 🔍 **Detailed Changes**: Module-specific changes
- ✅ **Quality Assurance**: Code quality, testing, security
- 🚀 **Deployment Impact**: Environment changes, breaking changes
- 📝 **Commit History**: Major commits listed
- 🔧 **Technical Details**: Dependencies, features, performance
- 👥 **Assignees**: Primary assignee and reviewers
- 🏷️ **Labels**: Appropriate labels
- 📋 **Checklist**: Pre/post merge tasks

#### 3. **Labels Requirements**
**Always include these labels:**
- `feature` (for new features)
- `fix` (for bug fixes)
- `refactor` (for refactoring)
- `enhancement` (for improvements)
- `ui/ux` (for UI changes)
- `architecture` (for architectural changes)

**Optional labels:**
- `breaking-change` (if breaking changes)
- `performance` (for performance improvements)
- `security` (for security updates)
- `documentation` (for docs updates)

## 🚀 PR Creation Process

### Step 1: Prepare Branch
```bash
# Ensure branch is up to date
git checkout develop
git pull origin develop
git checkout your-feature-branch
git rebase develop

# Run quality checks
flutter analyze
flutter test
dart format .
```

### Step 2: Create PR Content
1. **Copy template** from `PULL_REQUEST_TEMPLATE.md`
2. **Fill in all sections** with actual data
3. **Review content** for accuracy and completeness
4. **Add appropriate labels** and assignees

### Step 3: Create PR
```bash
# Using GitLab CLI
glab mr create \
  --title "feat(scope): description" \
  --description "$(cat PR_CONTENT.md)" \
  --source-branch your-feature-branch \
  --target-branch develop \
  --label "feature,ui/ux" \
  --assignee @your-username \
  --reviewer @reviewer1,@reviewer2
```

## 📊 Content Guidelines

### 📋 Overview Section
- **Keep it concise** (2-3 sentences)
- **Explain the "why"** not just the "what"
- **Mention impact** on users/developers
- **Reference related issues** if applicable

### 🎯 Type of Change
- **Check ALL applicable boxes**
- **Be specific** about what types of changes
- **Include breaking changes** if any

### 📊 Changes Summary
**Categorize changes into:**
- 🏗️ **Core Architecture Improvements**
- 🎨 **UI/UX Enhancements** 
- 🛠️ **Development Environment**
- 📦 **Dependencies & Tools**

### 🔍 Detailed Changes
**For each module changed:**
- **List specific changes** with bullet points
- **Mention new features** or improvements
- **Note bug fixes** or refactoring
- **Include file paths** for clarity

### ✅ Quality Assurance
**Always verify:**
- [x] **Code Quality**: Style guide, linting, formatting
- [x] **Testing**: All tests pass, new tests added
- [x] **Security**: No sensitive data, HTTPS, validation
- [x] **Performance**: Memory leaks, performance impact

### 🚀 Deployment Impact
**Document:**
- **Environment changes** for dev/staging/prod
- **Breaking changes** with migration guides
- **Performance impact** assessment
- **Security considerations**

## 🏷️ Label Guidelines

### **Feature Labels**
- `feature` - New functionality
- `enhancement` - Improvements to existing features
- `ui/ux` - User interface changes
- `architecture` - Structural changes

### **Fix Labels**
- `fix` - Bug fixes
- `hotfix` - Critical bug fixes
- `security` - Security updates

### **Technical Labels**
- `refactor` - Code refactoring
- `performance` - Performance improvements
- `documentation` - Documentation updates
- `testing` - Test-related changes

### **Process Labels**
- `breaking-change` - Breaking changes
- `draft` - Work in progress
- `ready-for-review` - Ready for review
- `approved` - Approved for merge

## 👥 Assignee & Reviewer Guidelines

### **Primary Assignee**
- **Always assign** to the PR author
- **Include team lead** for major changes
- **Add domain experts** for specialized changes

### **Reviewers**
- **Minimum 2 reviewers** for all PRs
- **Include team lead** for architectural changes
- **Add UI/UX reviewer** for UI changes
- **Include domain experts** for specialized modules

## 📝 Commit History Section

### **Major Feature Commits**
- **List top 10 commits** by importance
- **Include commit hash** and message
- **Focus on feature commits** not infrastructure

### **Infrastructure Commits**
- **List supporting commits** (deps, config, etc.)
- **Include important fixes** or refactors
- **Keep it concise** (5-7 commits max)

## 🔧 Technical Details

### **Dependencies Updated**
- **List package name** and version change
- **Explain why** dependency was updated
- **Note breaking changes** in dependencies

### **New Features**
- **List each feature** with clear description
- **Include user impact** where applicable
- **Mention technical benefits**

### **Performance Improvements**
- **Quantify improvements** where possible
- **Explain the optimization** technique
- **Include before/after** metrics if available

## 📋 Review Checklist

### **Before Creating PR**
- [ ] **All commits** follow conventional format
- [ ] **Code quality** checks pass
- [ ] **Tests pass** and coverage adequate
- [ ] **Documentation** updated if needed
- [ ] **Breaking changes** documented
- [ ] **Migration guide** provided if needed

### **PR Content Review**
- [ ] **Title** follows conventional format
- [ ] **Description** is complete and accurate
- [ ] **All sections** filled appropriately
- [ ] **Labels** are relevant and complete
- [ ] **Assignees** and reviewers assigned
- [ ] **Checklist** items verified

### **Post-Creation**
- [ ] **Notify reviewers** about the PR
- [ ] **Monitor CI/CD** pipeline
- [ ] **Address review comments** promptly
- [ ] **Update PR** if new commits added
- [ ] **Keep PR updated** with target branch

## 🚨 Common Mistakes to Avoid

### ❌ **Title Mistakes**
- Don't use generic titles like "Update code"
- Don't forget the scope in parentheses
- Don't use past tense ("Updated" instead of "Update")

### ❌ **Description Mistakes**
- Don't leave sections empty or with placeholders
- Don't forget to check appropriate type boxes
- Don't skip the quality assurance checklist
- Don't forget to document breaking changes

### ❌ **Process Mistakes**
- Don't create PR without running quality checks
- Don't forget to assign reviewers
- Don't skip the pre-merge checklist
- Don't merge without proper review

## 📞 Support

### **Questions About PR Creation**
- **Check this document** first
- **Review existing PRs** for examples
- **Ask team lead** for clarification
- **Use PR template** as reference

### **PR Template Location**
- **File**: `PULL_REQUEST_TEMPLATE.md`
- **Update**: When process changes
- **Version**: Keep track of template versions

---

**Remember**: Quality PRs lead to better code reviews, faster merges, and higher code quality. Always follow these guidelines to maintain consistency across the project. 