export async function fetchUptimeData() {
    try {
      const response = await fetch(
        'https://raw.githubusercontent.com/fragmetal/uptime/main/src/lib/uptime-data.json?t=' + Date.now()
      );
      const data = await response.json();
      
      // Transform data to match your expected format
      return {
        lastUpdated: new Date().toISOString(),
        sites: Object.entries(data).map(([url, stats]) => ({
          name: url.replace(/^https?:\/\//, ''),
          url,
          status: stats.up ? 'up' : 'down',
          lastChecked: new Date(stats.time).toISOString(),
          uptimePercentage: stats.up ? 100 : 0, // You'll need to calculate this over time
          responseTime: stats.ping || null
        }))
      };
    } catch (error) {
      console.error('Error fetching uptime data:', error);
      return null;
    }
  }