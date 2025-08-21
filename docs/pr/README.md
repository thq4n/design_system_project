# 📋 PR Documentation

## 📁 File Structure

### **Essential Files for PR Creation**
- **`PULL_REQUEST_TEMPLATE.md`** - Generic template for all PRs
- **`PR_CREATION_RULES.md`** - Comprehensive rules and guidelines for creating PRs
- **`README.md`** - This usage guide

## 🚀 Quick Start

### **Creating a New PR**

1. **Prepare your branch**:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout your-feature-branch
   git rebase develop
   ```

2. **Run quality checks**:
   ```bash
   flutter analyze
   flutter test
   dart format .
   ```

3. **Create PR content**:
   - Copy `PULL_REQUEST_TEMPLATE.md`
   - Fill in all sections with your data
   - Follow guidelines in `PR_CREATION_RULES.md`

4. **Create PR**:
   ```bash
   glab mr create \
     --title "type(scope): description" \
     --description "$(cat your-pr-content.md)" \
     --source-branch your-branch \
     --target-branch develop \
     --label "label1,label2"
   ```

## 📋 Guidelines

### **Title Format**
```
type(scope): concise description
```

**Examples:**
- `feat(dashboard): implement dashboard module`
- `fix(auth): resolve login validation issue`
- `refactor(core): extract common utilities`

### **Required Sections**
- 📋 **Overview**: What the PR accomplishes
- 🎯 **Type of Change**: Check appropriate boxes
- 🔄 **Branch Information**: Source, target, commits
- 📊 **Changes Summary**: Categorized changes
- 🔍 **Detailed Changes**: Module-specific changes
- ✅ **Quality Assurance**: Code quality, testing, security
- 🚀 **Deployment Impact**: Environment changes, breaking changes
- 📝 **Commit History**: Major commits listed
- 🔧 **Technical Details**: Dependencies, features, performance
- 👥 **Assignees**: Primary assignee and reviewers
- 🏷️ **Labels**: Appropriate labels
- 📋 **Checklist**: Pre/post merge tasks

### **Labels**
**Always include:**
- `feature` (for new features)
- `fix` (for bug fixes)
- `refactor` (for refactoring)
- `enhancement` (for improvements)
- `ui/ux` (for UI changes)
- `architecture` (for architectural changes)

## 📖 References

### **PR Creation Rules**
See `PR_CREATION_RULES.md` for detailed guidelines including:
- Pre-creation checklist
- Content requirements
- Process steps
- Common mistakes to avoid

### **PR Template**
See `PULL_REQUEST_TEMPLATE.md` for:
- Complete template structure
- All required sections
- Guidelines and placeholders

## 🔧 Maintenance

### **Updating Template**
- Edit `PULL_REQUEST_TEMPLATE.md` when process changes
- Update `PR_CREATION_RULES.md` accordingly
- Notify team of changes

### **Adding New Guidelines**
- Update `PR_CREATION_RULES.md` with new guidelines
- Keep this README current with any changes
- Ensure consistency across all documentation

## 🚨 Common Mistakes to Avoid

### **Title Mistakes**
- Don't use generic titles like "Update code"
- Don't forget the scope in parentheses
- Don't use past tense ("Updated" instead of "Update")

### **Description Mistakes**
- Don't leave sections empty or with placeholders
- Don't forget to check appropriate type boxes
- Don't skip the quality assurance checklist
- Don't forget to document breaking changes

### **Process Mistakes**
- Don't create PR without running quality checks
- Don't forget to assign reviewers
- Don't skip the pre-merge checklist
- Don't merge without proper review

## 📞 Support

### **Questions About PR Creation**
- **Check this document** first
- **Review PR_CREATION_RULES.md** for detailed guidelines
- **Use PULL_REQUEST_TEMPLATE.md** as reference
- **Ask team lead** for clarification

---

**Note**: Always follow the established guidelines to maintain consistency across the project. Quality PRs lead to better code reviews and faster merges. 