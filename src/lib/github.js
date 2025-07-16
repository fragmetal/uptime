import fs from 'fs';
import path from 'path';
import axios from 'axios';
import { fileURLToPath } from 'url';

// Get __dirname equivalent in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function checkSiteStatus(site) {
  const startTime = Date.now();
  try {
    const response = await axios.get(site.url, { timeout: 10000 });
    const responseTime = Date.now() - startTime;
    
    return {
      status: response.status >= 200 && response.status < 300 ? 'up' : 'down',
      responseTime,
      lastChecked: new Date().toISOString()
    };
  } catch (error) {
    return {
      status: 'down',
      responseTime: -1,
      lastChecked: new Date().toISOString()
    };
  }
}

async function updateUptimeData() {
  const uptimePath = path.join(__dirname, 'uptime-data.json');
  const data = JSON.parse(fs.readFileSync(uptimePath));
  
  for (const site of data.sites) {
    const result = await checkSiteStatus(site);
    
    // Update current status
    Object.assign(site, result);
    
    // Add to history (limit to last 100 checks)
    site.history = [...(site.history || []).slice(-99), {
      timestamp: result.lastChecked,
      status: result.status,
      responseTime: result.responseTime
    }];
    
    // Calculate uptime percentage
    const successfulChecks = site.history.filter(h => h.status === 'up').length;
    site.uptime = Math.round((successfulChecks / site.history.length) * 10000) / 100;
  }
  
  data.lastUpdated = new Date().toISOString();
  fs.writeFileSync(uptimePath, JSON.stringify(data, null, 2));
}

updateUptimeData().catch(console.error);