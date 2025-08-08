pragma Singleton
import QtQuick

QtObject {
    // Форматирует время в относительном формате (now, 5 min, 1 hour, yesterday, etc.)
    function formatRelativeTime(timestamp) {
        if (!timestamp || timestamp === 0) {
            return "unknown"
        }

        const now = new Date()
        const time = new Date(timestamp * 1000) // предполагаем, что timestamp в секундах
        const diffMs = now.getTime() - time.getTime()
        const diffSeconds = Math.floor(diffMs / 1000)
        const diffMinutes = Math.floor(diffSeconds / 60)
        const diffHours = Math.floor(diffMinutes / 60)
        const diffDays = Math.floor(diffHours / 24)

        // Менее минуты
        if (diffSeconds < 60) {
            return "now"
        }

        // Менее часа
        if (diffMinutes < 60) {
            if (diffMinutes === 1) {
                return "1 min"
            }
            return diffMinutes + " min"
        }

        // Менее суток
        if (diffHours < 24) {
            if (diffHours === 1) {
                return "1 hour"
            }
            return diffHours + " hours"
        }

        // Вчера
        if (diffDays === 1) {
            return "yesterday"
        }

        // Менее недели
        if (diffDays < 7) {
            return diffDays + " days"
        }

        // Менее месяца
        if (diffDays < 30) {
            const weeks = Math.floor(diffDays / 7)
            if (weeks === 1) {
                return "1 week"
            }
            return weeks + " weeks"
        }

        // Менее года
        if (diffDays < 365) {
            const months = Math.floor(diffDays / 30)
            if (months === 1) {
                return "1 month"
            }
            return months + " months"
        }

        // Больше года
        const years = Math.floor(diffDays / 365)
        if (years === 1) {
            return "1 year"
        }
        return years + " years"
    }
}
