package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Tạo thread pool với 4 threads để xử lý phân tích file
        ExecutorService executor = Executors.newFixedThreadPool(4);
        sce.getServletContext().setAttribute("analyzerExecutor", executor);

        System.out.println("==============================================");
        System.out.println("[AppStartupListener] Application started!");
        System.out.println("[AppStartupListener] Thread pool created with 4 threads");
        System.out.println("==============================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ExecutorService executor = (ExecutorService) sce.getServletContext().getAttribute("analyzerExecutor");

        if (executor != null) {
            System.out.println("==============================================");
            System.out.println("[AppStartupListener] Shutting down thread pool...");
            executor.shutdownNow();
            System.out.println("[AppStartupListener] Application stopped!");
            System.out.println("==============================================");
        }
    }
}
