#!/bin/bash
# Development setup script for ServerPulse

set -e  # Exit on any error

echo "🧠 ServerPulse Development Setup"
echo "================================"

# Check if we're in the project directory
if [ ! -f "requirements.txt" ]; then
    echo "❌ Please run this script from the ServerPulse project root directory"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
else
    echo "✅ Virtual environment already exists"
fi

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate || {
    echo "❌ Failed to activate virtual environment"
    exit 1
}

# Upgrade pip
echo "📦 Upgrading pip..."
pip install --upgrade pip

# Install dependencies
echo "📦 Installing dependencies..."
pip install -r requirements.txt

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "⚙️  Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env file - please configure your settings!"
    echo "📝 You need to set:"
    echo "   - BOT_TOKEN (Discord bot token)"
    echo "   - AI API keys (optional but recommended)"
    echo "   - Database URLs (if not using Docker)"
else
    echo "✅ .env file already exists"
fi

# Create logs directory
echo "📁 Creating logs directory..."
mkdir -p logs

# Check Docker availability
echo "🐳 Checking Docker availability..."
if command -v docker &> /dev/null && command -v docker-compose &> /dev/null; then
    echo "✅ Docker and Docker Compose are available"
    
    # Ask if user wants to start services
    read -p "🚀 Start database services with Docker? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🚀 Starting MongoDB and Redis..."
        docker-compose up -d mongodb redis
        
        # Wait a moment for services to start
        echo "⏳ Waiting for services to start..."
        sleep 5
        
        # Test connections
        echo "🔍 Testing database connections..."
        if docker-compose exec -T mongodb mongosh --eval "db.stats()" > /dev/null 2>&1; then
            echo "✅ MongoDB is running"
        else
            echo "⚠️  MongoDB connection test failed"
        fi
        
        if docker-compose exec -T redis redis-cli ping > /dev/null 2>&1; then
            echo "✅ Redis is running"
        else
            echo "⚠️  Redis connection test failed"
        fi
    fi
else
    echo "⚠️  Docker not available - you'll need to set up MongoDB and Redis manually"
fi

echo ""
echo "🎉 Development setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Configure your .env file with bot token and API keys"
echo "   2. Start the bot: python -m src.main"
echo "   3. Invite the bot to your test server with proper permissions"
echo ""
echo "🔧 Development commands:"
echo "   Start services: docker-compose up -d"
echo "   Stop services: docker-compose down"
echo "   View logs: docker-compose logs -f serverpulse"
echo "   Run tests: python -m pytest"
echo ""
echo "📚 Documentation: https://github.com/sizwinz/ServerPulse"
