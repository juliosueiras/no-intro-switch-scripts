import puppeteer from 'puppeteer';
import fs from 'fs';

function delay(time) {
	return new Promise(function(resolve) { 
		setTimeout(resolve, time)
	});
}

(async () => {
	const content = fs.readFileSync(process.argv[2], 'utf8');
	const gameName = content.split("\n").filter((x) => x.includes("Game Name:"))[0].split("Game Name: ")[1]
	const browser = await puppeteer.launch({
		headless: true,
		args: [ "--remote-debugging-port=9222", "--no-sandbox"],
	});

	const [page] = await browser.pages();
	await page.goto("https://forum.no-intro.org/posting.php?mode=post&f=7");
	await page.waitForSelector('#username');
	await page.type("#username", "<username>", {delay: 100});
	await page.waitForSelector('#password');
	await page.type("#password", "<password>", {delay: 100});
	await page.click(".button1");
	await page.waitForSelector('#subject');
	await page.type("#subject", `[NSW] ${gameName}`, {delay: 100});
	await page.waitForSelector('#message');
	await page.$eval('#message', (el, content) => el.value = content, content);
	await page.click(".default-submit-action");
	await delay(4000)
	await browser.close();
})();

