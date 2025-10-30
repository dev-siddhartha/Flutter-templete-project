#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');

function askFeatureName() {
    return new Promise((resolve) => {
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout,
        });
        rl.question('Enter feature name: ', (answer) => {
            rl.close();
            resolve(answer.trim());
        });
    });
}

function toPascalCase(str) {
    return str
        .replace(/[_-]+/g, ' ')
        .replace(/\s+(.)/g, (_, char) => char.toUpperCase())
        .replace(/^./, str[0].toUpperCase());
}

async function run() {
    let featureName = process.argv[2];

    if (!featureName) {
        featureName = await askFeatureName();
    }

    if (!featureName) {
        console.error('❌ Feature name is required.');
        process.exit(1);
    }

    const classBaseName = toPascalCase(featureName);
    const baseDir = path.join(__dirname, 'lib', 'features', featureName);

    const structure = {
        data: ['repo_impl'],
        domain: ['repo', 'model'],
        presentation: ['screens', 'widgets']
    };

    const parentDir = path.join(__dirname, 'lib', 'features');
    if (!fs.existsSync(parentDir)) {
        fs.mkdirSync(parentDir, { recursive: true });
    }

    if (!fs.existsSync(baseDir)) {
        fs.mkdirSync(baseDir);
        console.log(`📁 Created base folder: ${baseDir}`);
    } else {
        console.log(`⚠️ Feature folder already exists: ${baseDir}`);
    }

    // Create folder structure
    for (const [main, subs] of Object.entries(structure)) {
        const mainPath = path.join(baseDir, main);
        if (!fs.existsSync(mainPath)) {
            fs.mkdirSync(mainPath);
        }

        for (const sub of subs) {
            const subPath = path.join(mainPath, sub);
            if (!fs.existsSync(subPath)) {
                fs.mkdirSync(subPath);
            }
        }
    }

    // Create Dart files
    const repoDir = path.join(baseDir, 'domain', 'repo');
    const implDir = path.join(baseDir, 'data', 'repo_impl');

    const repoFilePath = path.join(repoDir, `${featureName}_repo.dart`);
    const implFilePath = path.join(implDir, `${featureName}_repo_impl.dart`);

    if (!fs.existsSync(repoFilePath)) {
        const repoClassContent = `abstract class ${classBaseName}Repo {
  // Define contract methods here
}
`;
        fs.writeFileSync(repoFilePath, repoClassContent, 'utf8');
        console.log(`✅ Created: ${repoFilePath}`);
    } else {
        console.log(`⚠️ Skipped (already exists): ${repoFilePath}`);
    }

    if (!fs.existsSync(implFilePath)) {
        const implClassContent = `import '../../domain/repo/${featureName}_repo.dart';

class ${classBaseName}RepoImpl extends ${classBaseName}Repo {
  // Implement methods here
}
`;
        fs.writeFileSync(implFilePath, implClassContent, 'utf8');
        console.log(`✅ Created: ${implFilePath}`);
    } else {
        console.log(`⚠️ Skipped (already exists): ${implFilePath}`);
    }

    console.log(`🎉 Feature '${featureName}' structure is ready inside lib/features.`);
}

run();